import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('Today'),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0007 complete',
              iconColor: Colors.green,
            ),
            _buildNotificationCard(
              icon: IconlyLight.close_square,
              title: 'Canceled',
              subtitle: 'You have canceled request no #0005',
              iconColor: Colors.red,
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Yesterday'),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0004 complete',
              iconColor: Colors.green,
            ),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0003 complete',
              iconColor: Colors.green,
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Desember 30, 2024'),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0003 complete',
              iconColor: Colors.green,
            ),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0002 complete',
              iconColor: Colors.green,
            ),
            _buildNotificationCard(
              icon: IconlyLight.tick_square,
              title: 'Approved Successful',
              subtitle: 'Request #0001 complete',
              iconColor: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.document), label: 'My Request'),
          BottomNavigationBarItem(icon: Icon(IconlyLight.plus), label: ''),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.time_circle), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
