import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/edit_of_request.dart';
import 'package:flutter_application_1/pages/new_request.dart';

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
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content:
              const Text('Apakah Anda yakin ingin menghapus proposal ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement logic to delete the proposal
                Navigator.of(context).pop(); // Tutup dialog setelah menghapus
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
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
        ],
      ),
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewRequest()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditOfList(
                            title:
                                'PEMINJAMAN RUANGAN UNTUK KEGIATAN STUDI BANDING HIMSI',
                            description: 'Deskripsi lama...',
                            requestDate: '09/12/2024 - 11:11 AM',
                            deadline: '10/12/2024 - 11:11 AM',
                          ),
                        ),
                      ).then((updatedDescription) {
                        if (updatedDescription != null) {
                          // TODO: Update the proposal with the new description
                        }
                      });
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
                      _showDeleteConfirmationDialog(
                          context); // Tampilkan dialog konfirmasi
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
