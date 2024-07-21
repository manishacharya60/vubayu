import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
      _selectedTime = TimeOfDay.now();
      _selectedSeason = '';
      _location = null;
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
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
        _showImageOptions();
      }
    } catch (e) {
   Text("Error picking image: $e");
    }
  }

  void _showImageOptions() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF2D3E50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Image Options',
          style: TextStyle(color: Color(0xFF00FFBc), fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(_image!.path),
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      sampleName: 'Sample 1',
                      season: 'Spring',
                      timing: 'Morning',
                      color: 'Dark Brown',
                      carbonSequestrationPotential: 75,
                      texture: 'Loamy',
                      waterRetentionCapacity: 60,
                      structure: 'Compact',
                      aggregateStabilityValue: 40,
                      moisture: 'Dry',
                      soilRelatedRespirationRate: 70,
                      organics: 'High',
                      contentsPerSquarePixels: 30,
                      roots: 'Not Visible',
                      totalCarbonInputOnSoil: 20,
                      porosity: 'Medium',
                      gasExchangeCapacity: 70.0,
                      rocksPresence: 'Not Present',
                      weatheringRate: 55.0,
                      imagePath: _image!.path,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFBc),
                foregroundColor: const Color(0xFF1a282f),
                minimumSize: const Size(120, 40),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    },
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
          textTheme: TextTheme(
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
            backgroundColor: Color(0xFF2D3E50),
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
              side: BorderSide(color: Color(0xFF00FFBc), width: 1),
            ),
            dayPeriodShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Color(0xFF00FFBc), width: 1),
            ),
            dayPeriodBorderSide: BorderSide(color: Color(0xFF00FFBc), width: 1),
            dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.selected) ? Color(0xFF00FFBc) : Color(0xFF2D3E50)),
            dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.selected) ? Color(0xFF1a282f) : Color(0xFF00FFBc)),
            hourMinuteColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.selected) ? Color(0xFF00FFBc) : Color(0xFF2D3E50)),
            hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.selected) ? Color(0xFF1a282f) : Color(0xFF00FFBc)),
            dialHandColor: Color(0xFF00FFBc),
            dialBackgroundColor: Color(0xFF34485c),
            hourMinuteTextStyle: TextStyle(
              fontSize: 28,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.normal,
            ),
            dayPeriodTextStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Quicksand',
            ),
            helpTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF00FFBc),
              fontFamily: 'Quicksand',
            ),
            dialTextColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.selected) ? Color(0xFF1a282f) : Color(0xFF00FFBc)),
            entryModeIconColor: Color(0xFF00FFBc),
          ),
          iconTheme: IconThemeData(
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
  if (picked != null && picked != _selectedTime) {
    setState(() {
      _selectedTime = picked;
    });
  }
}




Future<void> _selectLocation() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, ask the user to enable them
    bool userEnabledLocation = await _showLocationServiceDialog();
    if (!userEnabledLocation) {
      return; // User chose not to enable location services
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services still not enabled
    }
  }

  // Check location permission
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Show dialog explaining why the app needs location access
    bool userGrantedPermission = await _showLocationPermissionDialog();
    if (userGrantedPermission) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied
        return;
      }
    } else {
      // User chose not to grant permission
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately
    _showPermanentlyDeniedDialog();
    return;
  }

  // Get the current position
  try {
    Position position = await Geolocator.getCurrentPosition();
    // Get the place name from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _location = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? 'Unknown location';
      });
    }
  } catch (e) {
    setState(() {
      _location = 'Error getting location';
    });
  }
}

Future<bool> _showLocationServiceDialog() async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text('This app needs access to your location. Would you like to enable location services?'),
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
  ) ?? false;
}

Future<bool> _showLocationPermissionDialog() async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text('This app needs access to your location to determine your climate zone. Do you want to grant permission?'),
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
  ) ?? false;
}

void _showPermanentlyDeniedDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text('Location permission is permanently denied. Please enable it in your device settings.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
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
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            child: Column(
              children: [
               Row(
  children: [
    Expanded(child: _buildOptionCard('Click via', 'Camera', Icons.camera_outlined, ImageSource.camera)),
    const SizedBox(width: 12),
    Expanded(child: _buildOptionCard('Upload via', 'Gallery', Icons.upgrade_rounded, ImageSource.gallery)),
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
                        child: const Text('Save', style: TextStyle(fontSize: 16)),
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
                        child: const Text('Refresh', style: TextStyle(fontSize: 16)),
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
                icon: const Icon(LineAwesomeIcons.home_solid, color: Color(0xFF00ffbc)),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.favorite_border, color: Color(0xFF00ffbc)), onPressed: () {}),
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
                 onPressed: () {  },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Color(0xFF00ffbc)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserInfoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


Widget _buildOptionCard(String title, String subtitle, IconData icon, ImageSource source) {
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00FFBc)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF00FFBc), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _location ?? 'Location',
                    style: const TextStyle(color: Color(0xFF00FFBc), fontSize: 14),
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00FFBc)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Color(0xFF00FFBc), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _selectedTime.format(context),
                    style: const TextStyle(color: Color(0xFF00FFBc), fontSize: 14),
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