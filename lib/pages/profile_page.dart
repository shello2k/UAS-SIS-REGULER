import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final bool isStudent;

  ProfilePage({required this.isStudent});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isVerified = true;
  int _selectedIndex = 1;
  bool isLoading = true;
  Map<String, dynamic> userData = {};

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, 'login');
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userDoc = await _firestore
            .collection('users')
            .where('email', isEqualTo: currentUser.email)
            .get();

        if (userDoc.docs.isNotEmpty) {
          setState(() {
            userData = userDoc.docs.first.data();
            _isVerified = userData['isVerified'] ?? true;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found.')),
          );
        }
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is currently logged in.')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
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
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.orange,
                      Colors.white,
                    ],
                    stops: [0.0, 0.2],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Profile Card
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Profile Image
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.orange.shade400,
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage('assets/itenas.jpg'),
                                ),
                              ),
                              SizedBox(height: 16),
                              
                              // Name
                              Text(
                                userData['name'] ?? 'Nama Tidak Ditemukan',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              // Email
                              Text(
                                userData['email'] ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              
                              // Verification Badge
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _isVerified
                                      ? Colors.green.shade50
                                      : Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isVerified
                                          ? Icons.verified_user
                                          : Icons.warning,
                                      color: _isVerified
                                          ? Colors.green
                                          : Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      _isVerified
                                          ? 'Verified Account'
                                          : 'Not Verified',
                                      style: GoogleFonts.poppins(
                                        color: _isVerified
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Info Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                Icons.work,
                                'Position',
                                userData['department'] ?? 'Not Found',
                              ),
                              Divider(height: 30),
                              _buildInfoRow(
                                Icons.school,
                                'Program Studi',
                                userData['prodi'] ?? 'Not Found',
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30),
                      
                      // Logout Button
                      ElevatedButton.icon(
                        onPressed: _logout,
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 80), // Space for FAB
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 0) {
            Navigator.pushNamed(context, 'student_dashboard');
          }
        },
      ),
      floatingActionButton: widget.isStudent
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'new_request');
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.orange,
              elevation: 4,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.orange.shade400),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}