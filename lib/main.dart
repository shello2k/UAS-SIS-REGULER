import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_application_1/pages/bka_dashboard.dart';
import 'package:flutter_application_1/pages/bku_dashboard.dart';
import 'package:flutter_application_1/pages/detail_mail.dart';
import 'package:flutter_application_1/pages/faculty_dashboard.dart';
import 'package:flutter_application_1/pages/head_dashboard.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'login_page.dart';
import 'package:flutter_application_1/pages/profile_page_staff.dart'
    as staff; // Import dengan alias 'staff'

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/admin_dashboard.dart';
import 'pages/student_dashboard.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((error) {
    print('Error initializing Firebase: $error');
  });

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ChangeNotifierProvider(
        create: (_) => AppState(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: LoginPage(),
      routes: {
        'login': (context) => LoginPage(),
        'admin_dashboard': (context) => AdminDashboard(),
        'student_dashboard': (context) => StudentDashboard(),
        'head_dashboard': (context) => HeadDashboard(),
        'faculty_dashboard': (context) => FacultyDashboard(),
        'bku_dashboard': (context) => BkuDashboard(),
        'bka_dashboard': (context) => BkaDashboard(),
        'profile_page': (context) =>
            ProfilePage(isStudent: true), // Menambahkan parameter isStudent
        'profile_page_staff': (context) => staff.ProfilePageStaff(role: ''), // Menambahkan parameter role
      },
    );
  }

  // Function to navigate to DetailMail with kode_proposal
  static void navigateToDetailMail(BuildContext context, String kode_proposal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMail(kode_proposal: kode_proposal),
      ),
    );
  }
}
