import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Untuk kReleaseMode
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'login_page.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode, // Aktifkan hanya di mode debug
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
      locale: DevicePreview.locale(context), // Lokalisasi dari DevicePreview
      builder: DevicePreview.appBuilder, // Builder khusus DevicePreview
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Sesuai pengaturan sistem
      home: LoginPage(), // Halaman utama Anda
    );
  }
}
