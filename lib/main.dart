import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Asegúrate de que el archivo se llama login_screen.dart

void main() {
  runApp(const MediaAlertApp());
}

class MediaAlertApp extends StatelessWidget {
  const MediaAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediAlert',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
