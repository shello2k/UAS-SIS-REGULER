import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  void _CreateAccount(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _email, _password, _username, _role = 'student';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buat Akun Pengguna'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Username Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Role Selection
                  DropdownButtonFormField<String>(
                    value: _role,
                    onChanged: (String? newValue) {
                      _role = newValue;
                    },
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(),
                    ),
                    items: ['student', 'kaprodi', 'fakultas']
                        .map((role) => DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    // Membuat akun baru di Firebase Auth
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _email!,
                      password: _password!,
                    );

                    // Memastikan bahwa userCredential tidak null
                    if (userCredential.user != null) {
                      // Menyimpan informasi user di Firestore
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'username': _username,
                        'email': _email,
                        'role': _role,
                      });

                      Navigator.of(context).pop(); // Menutup dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Akun berhasil dibuat!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Gagal membuat akun, coba lagi.')),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.message}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Unexpected error: $e')),
                    );
                  }
                }
              },
              child: Text('Create Account'),
            ),
          ],
        );
      },
    );
  }

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
                    _CreateAccount(context);
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
