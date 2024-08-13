// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:vubayu/models/soil.dart';
import 'package:vubayu/utils/json_parsing.dart';
import 'package:vubayu/utils/prompt_utils.dart';
import 'results.dart';
import 'user.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _locationController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedSeason = '';
  String? _location;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  late GenerativeModel geminiProModel;

  @override
  void initState() {
    super.initState();
    const apiKey =
        String.fromEnvironment('API_KEY', defaultValue: 'key not found');

    if (apiKey == 'key not found') {
      throw InvalidApiKey(
        'Key not found in environment. Please add an API key.',
      );
    }

    geminiProModel = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: const String.fromEnvironment('API_KEY'),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveInput() async {
    if (!mounted) return;

    if (_image == null || _location == null || _selectedSeason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select image, location, time & season',
            style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16),
          ),
          backgroundColor: Color(0xFF2D3E50),
        ),
      );
      return;
    }

    print("-----------------");
    print("Location: $_location");
    print("Time: $_selectedTime");
    print("Season: $_selectedSeason");
    print("Image Path: ${_image?.path}");
    print("-----------------");

    // Build the prompt
    final promptText =
        buildPrompt(context, _location, _selectedTime, _selectedSeason);

    // Read the image file as bytes
    final imageBytes = await File(_image!.path).readAsBytes();

    // Create the GenerativeModel instance
    const apiKey =
        String.fromEnvironment('API_KEY', defaultValue: 'key not found');
    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 8000),
    );

    // Create the prompt and image parts
    final prompt = TextPart(promptText);
    final imageParts = [
      DataPart('image/jpeg', imageBytes),
    ];

    // Generate content using the Google Gemini API
    final response = await model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);

    // Print the response for debugging
    print(response.text);

    // Parse the JSON response
    final jsonResponse = jsonDecode(cleanJson(response.text!));
    final soil = Soil.fromJson(jsonResponse);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          sampleName: 'Sample 1',
          season: _selectedSeason,
          timing: _selectedTime.format(context),
          color: soil.color,
          carbonSequestrationPotential: soil.carbonSequestrationPotential,
          texture: soil.soilType,
          waterRetentionCapacity: soil.waterRetentionCapacity,
          structure: soil.structure,
          aggregateStabilityValue: soil.aggregateStabilityValue,
          moisture: soil.moistureContent,
          soilRelatedRespirationRate: soil.soilRespirationRate,
          organics: soil.organicMatter,
          contentsPerSquarePixels: soil.matterContentPerSquarePixels,
          roots: soil.rootGrowth,
          totalCarbonInputOnSoil: soil.carbonInput,
          porosity: soil.porosity,
          gasExchangeCapacity: soil.gasExchangeCapacity,
          rocksPresence: soil.rocksPresence,
          weatheringRate: soil.weatheringRate,
          imagePath: _image!.path,
          soil: soil,
        ),
      ),
    );
  }

  void _refreshInputs() {
    setState(() {
      _locationController.clear();
      _selectedTime = TimeOfDay.now();
      _selectedSeason = '';
      _location = null;
      _image = null;
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

  Future<void> _takePicture(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null && mounted) {
        setState(() {
          _image = pickedFile;
        });
        _showProcessedMessage();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    }
  }

  void _showProcessedMessage() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF00FFBc),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Text(
            'Image processed successfully',
            style: TextStyle(color: Color(0xFF1a282f), fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.only(
            bottom: 0.2, left: 20.0, right: 20.0), // Add this line
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00FFBc),
              surface: Color(0xFF2D3E50),
              onSurface: Color(0xFF00FFBc),
            ),
            dialogBackgroundColor: const Color(0xFF2D3E50),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Color(0xFF00FFBc),
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w400,
              ),
              labelLarge: TextStyle(
                fontFamily: 'Quicksand',
                color: Color(0xFF00FFBc),
                fontSize: 16,
              ),
            ).apply(
              fontFamily: 'Quicksand',
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color(0xFF2D3E50),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48),
                side: const BorderSide(color: Color(0xFF00FFBc), width: 1),
              ),
              timeSelectorSeparatorColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? const Color(0xFF2D3E50)
                      : const Color(0xFF2D3E50)),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: Color(0xFF00FFBc), width: 1),
              ),
              dayPeriodBorderSide:
                  const BorderSide(color: Color(0xFF00FFBc), width: 1),
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF00FFBc)
                      : const Color(0xFF2D3E50)),
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF1a282f)
                      : const Color(0xFF00FFBc)),
              hourMinuteColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF00FFBc)
                      : const Color(0xFF2D3E50)),
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF1a282f)
                      : const Color(0xFF00FFBc)),
              dialHandColor: const Color(0xFF00FFBc),
              dialBackgroundColor: const Color(0xFF34485c),
              hourMinuteTextStyle: const TextStyle(
                fontSize: 28,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.normal,
              ),
              dayPeriodTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Quicksand',
              ),
              helpTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFF00FFBc),
                fontFamily: 'Quicksand',
              ),
              dialTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF1a282f)
                      : const Color(0xFF00FFBc)),
              entryModeIconColor: const Color(0xFF00FFBc),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xFF00FFBc),
              opacity: 0.8,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null && picked != _selectedTime && mounted) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool userEnabledLocation = await _showLocationServiceDialog();
      if (!userEnabledLocation) {
        return;
      }
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      bool userGrantedPermission = await _showLocationPermissionDialog();
      if (userGrantedPermission) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      } else {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermanentlyDeniedDialog();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty && mounted) {
        Placemark place = placemarks[0];
        setState(() {
          _location = place.locality ??
              place.subAdministrativeArea ??
              place.administrativeArea ??
              'Unknown location';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _location = 'Error getting location';
        });
      }
    }
  }

  Future<bool> _showLocationServiceDialog() async {
    if (!mounted) return false;
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location Services Disabled'),
              content: const Text(
                  'This app needs access to your location. Would you like to enable location services?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showLocationPermissionDialog() async {
    if (!mounted) return false;
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF2D3E50),
              title: Row(
                children: const [
                  Icon(
                    Icons.location_on,
                    color: Color(0xFF00FFBC),
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Permission Required',
                    style: TextStyle(color: Color(0xFF00FFBC), fontSize: 20),
                  ),
                ],
              ),
              content: const Text(
                'This app needs access to your location to determine your climate zone. Do you want to grant permission?',
                style: TextStyle(color: Color(0xFF00FFBC)),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showPermanentlyDeniedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D3E50),
          title: const Text('Location Permission Denied',
              style: TextStyle(color: Color(0xFF00FFBC), fontSize: 20)),
          content: const Text(
              'Location permission is permanently denied. Please enable it in your device settings.',
              style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK',
                  style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // ... The rest of the code (build method and other widget methods) remains the same

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
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _buildOptionCard('Click via', 'Camera',
                            Icons.camera_outlined, ImageSource.camera)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildOptionCard('Upload via', 'Gallery',
                            Icons.upgrade_rounded, ImageSource.gallery)),
                  ],
                ),
                const SizedBox(height: 8),
                _buildClimateZoneCard(),
                const SizedBox(height: 8),
                _buildTimingCard(),
                const SizedBox(height: 8),
                _buildSeasonCard(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: _saveInput,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: const Color(0xFF00ffbc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Proceed',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 140,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: _refreshInputs,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: const Color(0xFF00ffbc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Refresh',
                            style: TextStyle(fontSize: 16)),
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
                icon: const Icon(LineAwesomeIcons.home_solid,
                    color: Color(0xFF00ffbc)),
                onPressed: () {},
              ),
              IconButton(
                  icon: const Icon(Icons.favorite_border,
                      color: Color(0xFF00ffbc)),
                  onPressed: () {}),
              FloatingActionButton(
                onPressed: () => _takePicture(ImageSource.camera),
                backgroundColor: const Color(0xFF00FFBc),
                foregroundColor: const Color(0xFF1a282f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.adjust_outlined),
              ),
              IconButton(
                icon: const Icon(Icons.map_outlined, color: Color(0xFF00ffbc)),
                onPressed: () {},
              ),
              IconButton(
                icon:
                    const Icon(Icons.person_outline, color: Color(0xFF00ffbc)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      String title, String subtitle, IconData icon, ImageSource source) {
    return InkWell(
      onTap: () => _takePicture(source),
      child: Card(
        color: const Color(0xFF00FFBc),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
      ),
    );
  }

  Widget _buildClimateZoneCard() {
    return Card(
      color: const Color(0xFF2C3E50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Where is your climate zone?',
              style: TextStyle(color: Color(0xFF00FFBc), fontSize: 16),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectLocation(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFBc)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Color(0xFF00FFBc), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _location ?? 'Location',
                      style: const TextStyle(
                          color: Color(0xFF00FFBc), fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Color(0xFF00FFBc)),
                  ],
                ),
              ),
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
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'When was the image taken?',
              style: TextStyle(color: Color(0xFF00FFBc), fontSize: 16),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectTime(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FFBc)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time,
                        color: Color(0xFF00FFBc), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _selectedTime.format(context),
                      style: const TextStyle(
                          color: Color(0xFF00FFBc), fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Color(0xFF00FFBc)),
                  ],
                ),
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
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is your season context?',
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
        backgroundColor:
            isSelected ? const Color(0xFF00FFBc) : const Color(0xFF2C3E50),
        foregroundColor:
            isSelected ? const Color(0xFF1a282f) : const Color(0xFF00FFBc),
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
