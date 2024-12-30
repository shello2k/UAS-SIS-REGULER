import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk kReleaseMode
import 'package:device_preview/device_preview.dart';
import 'package:flutter_application_1/pages/admin_dashboard.dart';
import 'package:flutter_application_1/pages/adminn_dashboard.dart';
import 'package:flutter_application_1/pages/list_of_request.dart';
import 'package:flutter_application_1/pages/new_request.dart';
import 'package:flutter_application_1/pages/notification_page.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'login_page.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => ChangeNotifierProvider(
          create: (_) => AppState(),
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Integrasi dengan DevicePreview
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: NewRequest(), // Halaman utama Anda
    );
  }
}
