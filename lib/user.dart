import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a282f),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00ffbc)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
    padding: EdgeInsets.only(right: 28, top: 4),  // Adjust these values as needed
    child: Text(
                'vubayu info',
                style: TextStyle(color: Color(0xFF00FFbc), fontSize: 20),
              ),
  ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF00FFBC),
              child: Icon(Icons.person, size: 25, color: Color(0xFF1a282f)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Hari Bahadur',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00ffbc)),
            ),
            const Text(
              'haribahadur@gmail.com',
              style: TextStyle(fontSize: 16, color: Color(0xFF00ffbc)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF1a282f),
                backgroundColor: const Color(0xFF00FFBC),
                minimumSize: const Size(160, 36),
              ),
              onPressed: () {
                // Handle upgrade
              },
              child: const Text('Standard User', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            _buildMenuItem(Icons.edit_rounded, 'Edit Username'),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.lock, 'Update Password'),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.help, 'Help & Support'),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.settings, 'Notification Settings'),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.insert_chart_outlined_rounded, 'Sample History'),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.expand_circle_down_outlined, 'Logout'),
          ],
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
              IconButton(icon: const Icon(Icons.map_outlined, color: Color(0xFF00ffbc)), onPressed: () {}),
              IconButton(icon: const Icon(Icons.person_outline, color: Color(0xFF00ffbc)), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // Handle menu item tap
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minVerticalPadding: 0,
          dense: true,
          visualDensity: VisualDensity(vertical: -4),
          leading: Icon(icon, color: Color(0xFF00ffbc), size: 20),
          title: Text(title, style: TextStyle(color: Color(0xFF00ffbc), fontSize: 16)),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF00ffbc), size: 18),
        ),
      ),
    );
  }
}
