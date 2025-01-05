import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';
import 'package:flutter_application_1/models/proposal.dart';
import 'package:flutter_application_1/widgets/bottom_navbar.dart'; // masih statis
*/

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Tambahkan navigasi sesuai dengan index yang dipilih
    if (index == 1) {
      // Navigasi ke halaman Profile
      Navigator.pushNamed(context, '/profile');
    } else if (index == 2) {
      // Navigasi ke halaman Ajukan Proposal Baru
      Navigator.pushNamed(context, '/ajukan-proposal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Dashboard Mahasiswa',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Proposal Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Logika untuk ikon pencarian
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        // Logika untuk ikon sortir
                      },
                      icon: const Icon(Icons.sort),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildProposalCard(context, 'Held'),
                  const SizedBox(height: 10),
                  _buildProposalCard(context, 'Submitted'),
                  const SizedBox(height: 10),
                  _buildProposalCard(context, 'Cancel'),
                  const SizedBox(height: 10),
                  _buildProposalCard(context, 'Approved'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajukan Proposal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildProposalCard(BuildContext context, String status) {
    Color statusColor;
    switch (status) {
      case 'Submitted':
        statusColor = Colors.blue;
        break;
      case 'Cancel':
        statusColor = Colors.red;
        break;
      case 'Approved':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
                  'P0001',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Judul Proposal',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              'KEGIATAN PENGABDIAN MASYARAKAT DI DESA BINAAN',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tanggal Pengajuan',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Deadline',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '01/01/2024 - 10:00 AM',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '05/01/2024 - 10:00 AM',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            if (status == 'Cancel') ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Navigasi ke halaman edit dan resend proposal
                    },
                    child: const Text(
                      'Edit and Resend',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Logika untuk menghapus proposal
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
