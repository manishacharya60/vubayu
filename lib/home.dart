import 'package:flutter/material.dart';
// ignore: unused_import
import 'results.dart';
import 'user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _locationController = TextEditingController();
  double _selectedTime = 0;
  String _selectedSeason = '';

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _saveInput() {
    // Implement your save logic here
    // You can access the values:
    // Location: _locationController.text
    // Time: _selectedTime
    // Season: _selectedSeason
  }

  void _refreshInputs() {
    setState(() {
      _locationController.clear();
      _selectedTime = 0;
      _selectedSeason = '';
    });
  }

  void _toggleSeason(String season) {
    setState(() {
      if (_selectedSeason == season) {
        _selectedSeason = '';
      } else {
        _selectedSeason = season;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a282f),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                ' vubayu',
                style: TextStyle(color: Color(0xFF00FFbc), fontSize: 24),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 12.0),
              child: Image.asset(
                'assets/signlogo.png',
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1a282f),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0), // Adjusted top padding
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildOptionCard('Click via', 'Camera', Icons.add)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildOptionCard('Upload via', 'Gallery', Icons.upgrade_rounded)),
                  ],
                ),
                const SizedBox(height: 8),
                _buildClimateZoneCard(),
                const SizedBox(height: 8),
                _buildTimingCard(),
                const SizedBox(height: 8),
                _buildSeasonCard(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                  children: [
                    SizedBox(
                      width: 140, // Decreased width
                      height: 36, // Decreased height
                      child: ElevatedButton(
                        onPressed: _saveInput,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: const Color(0xFF00ffbc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                              // Increased border radius
                          ),
                        ),
                        child: const Text('Save', style: TextStyle(fontSize: 16)), // Decreased font size
                      ),
                    ),
                    const SizedBox(width: 24), // Increased space between buttons
                    SizedBox(
                      width: 140, // Decreased width
                      height: 36, // Decreased height
                      child: ElevatedButton(
                        onPressed: _refreshInputs,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: const Color(0xFF00ffbc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24), 
                              // Increased border radius
                          ),
                        ),
                        child: const Text('Refresh', style: TextStyle(fontSize: 16)), // Decreased font size
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF27374D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.adjust_outlined, color: Color(0xFF00ffbc)),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.favorite_border, color: Color(0xFF00ffbc)), onPressed: () {}),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: const Color(0xFF00FFBc),
                foregroundColor: const Color(0xFF1a282f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.add),
              ),
              IconButton(icon: const Icon(Icons.map_outlined, color: Color(0xFF00ffbc)), onPressed: (){
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ResultsPage(
      sampleName: 'Sample 1',
  season: 'Spring',
  timing: 'Morning',
  color: 'Dark Brown',
  carbonSequestrationPotential: 75,
  texture: 'Loamy',
  waterRetentionCapacity: 60,
  structure: 'Compact',
  moisture: 'Dry',
  organics: 'High',
  roots: 'Not Visible',
  aggregateStabilityValue: 40,
  soilRelatedRespirationRate: 70,
  contentsPerSquarePixels: 30,
  totalCarbonInputOnSoil: 20,

    ),
  ),
);

              }
              ),
              IconButton(icon: const Icon(Icons.person_outline, color: Color(0xFF00ffbc)), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInfoPage(


                  )),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String title, String subtitle, IconData icon) {
    return Card(
      color: const Color(0xFF00FFBc),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Increased border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Icon(icon, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildClimateZoneCard() {
    return Card(
      color: const Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Increased border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your climate zone',
              style: TextStyle(color: Color(0xFF00FFBc), fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Location',
                      hintStyle: TextStyle(color: Color(0xFF009971)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00FFbc)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00FFbc)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.location_on, color: Color(0xFF00FFBc)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingCard() {
    return Card(
      color: const Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Increased border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your image timing',
                  style: TextStyle(color: Color(0xFF00FFBc), fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FFbc),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'about ${_selectedTime.round()} ${_selectedTime < 12 ? 'am' : 'pm'}',
                    style: const TextStyle(color: Color(0xFF1a282f), fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              ),
              child: Slider(
                value: _selectedTime,
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value;
                  });
                },
                min: 0,
                max: 23,
                divisions: 23,
                activeColor: const Color(0xFF00FFBc),
                inactiveColor: const Color(0xFF1a282f),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonCard() {
    return Card(
      color: const Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Increased border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your season context',
              style: TextStyle(color: Color(0xFF00FFBc), fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSeasonButton('Spring', Icons.air_outlined),
                _buildSeasonButton('Summer', Icons.wb_sunny),
                _buildSeasonButton('Autumn', Icons.eco),
                _buildSeasonButton('Winter', Icons.ac_unit),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonButton(String season, IconData icon) {
    final isSelected = _selectedSeason == season;
    return ElevatedButton(
      onPressed: () => _toggleSeason(season),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF00FFBc) : const Color(0xFF2C3E50),
        foregroundColor: isSelected ? const Color(0xFF1a282f) : const Color(0xFF00FFBc),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(season, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}