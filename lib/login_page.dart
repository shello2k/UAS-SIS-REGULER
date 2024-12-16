import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/student_dashboard.dart';
import 'package:flutter_application_1/pages/head_dashboard.dart';
import 'package:flutter_application_1/pages/faculty_dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _code;

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_code == 'mahasiswa') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => StudentDashboard()),
        );
      } else if (_code == 'kaprodi') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => HeadDashboard()),
        );
      } else if (_code == 'fakultas') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => FacultyDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid code. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image above the form
              Image.asset(
                'assets/login_image.png', // Replace with your own image asset path
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20),

              // Login Box
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Your Code',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Code cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _code = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
