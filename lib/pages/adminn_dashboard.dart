import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selamat Datang, Admin!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: screenWidth > 600 ? 3 : 2,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCard(
                  context,
                  title: 'Buat Akun Pengguna',
                  icon: Icons.person_add,
                  onTap: () {
                    // Navigasi ke halaman buat akun pengguna
                  },
                ),
                _buildCard(
                  context,
                  title: 'Kelola Data Pengguna',
                  icon: Icons.manage_accounts,
                  onTap: () {
                    // Navigasi ke halaman kelola data pengguna
                  },
                ),
                _buildCard(
                  context,
                  title: 'Lihat Log Aktivitas',
                  icon: Icons.history,
                  onTap: () {
                    // Navigasi ke halaman log aktivitas
                  },
                ),
                _buildCard(
                  context,
                  title: 'Tambah Kategori Surat',
                  icon: Icons.category,
                  onTap: () {
                    // Navigasi ke halaman tambah kategori surat
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
      elevation: 8,
      color: Colors.orange[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.orange),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
