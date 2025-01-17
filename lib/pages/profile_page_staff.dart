import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class ProfilePageStaff extends StatefulWidget {
  final String
      role; // Parameter untuk menentukan peran pengguna (Head, Faculty, BKU, BKA)

  ProfilePageStaff(
      {required this.role}); // Constructor untuk menerima parameter

  @override
  _ProfilePageStaffState createState() => _ProfilePageStaffState();
}

class _ProfilePageStaffState extends State<ProfilePageStaff> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isVerified = true; // Status verifikasi akun
  int _selectedIndex = 1; // Indeks untuk BottomNavigationBar
  bool isLoading = true; // Loading state
  Map<String, dynamic> userData = {}; // Data pengguna

  // Fungsi untuk logout
  Future<void> _logout() async {
    try {
      await _auth.signOut(); // Logout dari Firebase
      Navigator.pushReplacementNamed(
          context, 'login'); // Navigasi ke halaman login
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  // Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> _fetchUserData() async {
    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Filter pengguna berdasarkan email yang dimasukkan saat login
        final userDoc = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentUser.email)
            .get();

        if (userDoc.docs.isNotEmpty) {
          setState(() {
            userData = userDoc.docs.first.data();
            _isVerified = userData['isVerified'] ??
                true; // Mendapatkan status verifikasi dari data
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found.')),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is currently logged in.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Profil
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/itenas.jpg'), // Ganti dengan gambar profil
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Nama Lengkap
                  Center(
                    child: Text(
                      userData['name'] ?? 'Nama Tidak Ditemukan',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      userData['email'] ?? '',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Posisi
                  Text(
                    'Posisi: ${userData['department'] ?? 'Posisi Tidak Ditemukan'}',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Jurusan
                  Text(
                    'Jurusan: ${userData['prodi'] ?? 'Jurusan Tidak Ditemukan'}',
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
                        _isVerified ? 'Verified Account' : 'Not Verified',
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
                context, 'staff_dashboard'); // Ganti dengan route yang sesuai
          }
        },
      ),
    );
  }
}
