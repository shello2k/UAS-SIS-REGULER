import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class ProfilePage extends StatefulWidget {
  final bool
      isStudent; // Parameter untuk menentukan apakah pengguna adalah mahasiswa

  ProfilePage(
      {required this.isStudent}); // Constructor untuk menerima parameter

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isVerified = true; // Status verifikasi akun
  int _selectedIndex = 1; // Indeks untuk BottomNavigationBar

  // Fungsi untuk logout
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Logout dari Firebase
      Navigator.pushReplacementNamed(
          context, 'login'); // Navigasi ke halaman login
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false, // Menghilangkan back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto Profil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile_placeholder.png'), // Ganti dengan gambar profil
              ),
            ),
            const SizedBox(height: 20),
            // Nama Lengkap
            Center(
              child: Text(
                'Mira Musrini Barmawi', // Ganti dengan nama pengguna
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'S.Si., M.T.', // Ganti dengan gelar pengguna
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // Posisi
            Text(
              'Posisi: Kaprodi', // Ganti dengan posisi pengguna
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Jurusan
            Text(
              'Jurusan: Sistem Informasi', // Ganti dengan jurusan pengguna
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Tombol Verifikasi
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isVerified
                      ? Colors.green
                      : Colors
                          .red, // Warna tombol berdasarkan status verifikasi
                ),
                onPressed: () {
                  // TODO: Implement logic for Firebase Authentication verification
                  setState(() {
                    _isVerified =
                        !_isVerified; // Toggle status verifikasi untuk demo
                  });
                },
                child: Text(
                  _isVerified
                      ? 'Verified Account'
                      : 'Not Verified', // Teks tombol berdasarkan status verifikasi
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tombol Logout
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Warna tombol logout
                ),
                onPressed: _logout, // Panggil fungsi logout
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Navigasi ke halaman yang sesuai
          if (index == 0) {
            Navigator.pushNamed(
                context, 'student_dashboard'); // Ganti dengan route yang sesuai
          }
        },
      ),
      floatingActionButton:
          widget.isStudent // Tampilkan FAB hanya untuk mahasiswa
              ? FloatingActionButton(
                  onPressed: () {
                    // TODO: Implement logic for creating a new proposal
                    Navigator.pushNamed(context,
                        'new_request'); // Ganti dengan route untuk pengajuan proposal
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.orange,
                )
              : null, // Jika bukan mahasiswa, tidak ada FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}