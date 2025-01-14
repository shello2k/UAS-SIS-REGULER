import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        if (_email == 'admin123@gmail.com') {
          Navigator.pushReplacementNamed(context, 'admin_dashboard');
        } else {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            String email = user.email!;

            QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: email)
                .get();

            if (userSnapshot.docs.isNotEmpty) {
              DocumentSnapshot userDoc = userSnapshot.docs[0];

              if (userDoc.data() != null && userDoc['department'] != null) {
                String department = userDoc['department'];

                if (department == 'Students Association') {
                  Navigator.pushReplacementNamed(context, 'student_dashboard');
                } else if (department == 'Head of Study Program') {
                  Navigator.pushReplacementNamed(context, 'head_dashboard');
                } else if (department == 'Faculty') {
                  Navigator.pushReplacementNamed(context, 'faculty_dashboard');
                } else if (department == 'BKU') {
                  Navigator.pushReplacementNamed(context, 'bku_dashboard');
                } else if (department == 'BKA') {
                  Navigator.pushReplacementNamed(context, 'bka_dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Unknown role')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Role not found in user data')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User not found in Firestore')),
              );
            }
          }
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo Itenas
              Column(
                children: [
                  Image.asset(
                    'assets/login_image.png',
                    width: 160,
                    height: 160,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Institut Teknologi Nasional',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              // Kotak Form Login
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Teks Login Title
                    Text(
                      'Login into your account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Input
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your Email',
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.orange),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.orange),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
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
                          SizedBox(height: 8),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPasswordPage()));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          // Tombol Login
                          ElevatedButton(
                            onPressed: _login,
                            child: Text('Login Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
