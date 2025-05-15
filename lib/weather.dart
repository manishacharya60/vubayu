import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData;
  String error = '';

  final String apiKey = ''; // 🔐 Replace this with your actual key

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      final url =
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${position.latitude},${position.longitude}&days=4&aqi=no&alerts=no';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      } else {
        setState(() {
          error = 'Failed to load weather data';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching weather: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a282f),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a282f),
        title: const Text('Weather Forecast',
            style: TextStyle(color: Color(0xFF00FFbc))),
        iconTheme: const IconThemeData(color: Color(0xFF00FFbc)),
      ),
      body: weatherData == null
          ? Center(
              child: error.isNotEmpty
                  ? Text(error, style: const TextStyle(color: Colors.red))
                  : const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF00FFbc))))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTodayWeather(),
                  const SizedBox(height: 24),
                  const Text('3-Day Forecast',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF00FFbc),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Expanded(child: _buildForecastList()),
                ],
              ),
            ),
    );
  }

  Widget _buildTodayWeather() {
    final today = weatherData!['forecast']['forecastday'][0]['day'];
    final city = weatherData!['location']['name'];
    final desc = today['condition']['text'];
    final iconUrl = "https:${today['condition']['icon']}";
    final temp = today['avgtemp_c'];
    final feels = today['avgtemp_c']; // No "feels like" in free tier
    final humidity = today['avghumidity'];
    final wind = today['maxwind_kph'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.network(iconUrl, width: 64, height: 64),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(city,
                    style: const TextStyle(
                        color: Color(0xFF00FFbc),
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                Text(
                  desc,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 4),
                Text('Temp: ${temp.round()}°C',
                    style: const TextStyle(color: Colors.white)),
                Text('Humidity: $humidity% | Wind: ${wind}km/h',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastList() {
    final forecastDays = weatherData!['forecast']['forecastday'].skip(1);

    return ListView.builder(
      itemCount: forecastDays.length,
      itemBuilder: (context, index) {
        final item = forecastDays.elementAt(index);
        final date = DateTime.parse(item['date']);
        final day = item['day'];
        final desc = day['condition']['text'];
        final iconUrl = "https:${day['condition']['icon']}";
        final temp = day['avgtemp_c'];

        return Card(
          color: const Color(0xFF2C3E50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Image.network(iconUrl, width: 40, height: 40),
            title: Text(
              '${_weekday(date)} - ${date.day}/${date.month}',
              style: const TextStyle(color: Color(0xFF00FFbc)),
            ),
            subtitle: Text(
              '$desc | ${temp.round()}°C',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  String _weekday(DateTime date) {
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }
}
