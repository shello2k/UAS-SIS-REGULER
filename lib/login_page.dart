import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/student_dashboard.dart';
import 'package:flutter_application_1/pages/head_dashboard.dart';
import 'package:flutter_application_1/pages/faculty_dashboard.dart';
import 'package:flutter_application_1/pages/admin_dashboard.dart'; 

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
      if (_code == '162022001') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => StudentDashboard()),
        );
      } else if (_code == '162022002') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => HeadDashboard()),
        );
      } else if (_code == '162022003') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => FacultyDashboard()),
        );
      } else if (_code == 'adminCode') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => AdminPage()), 
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.png', 
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: 300, 
              height: 300, 
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4), 
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login_image.png', 
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Your Code',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 9, 
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Code cannot be empty';
                            } else if (value.length != 9) {
                              return 'Code must be 9 digits long';
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2), 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
