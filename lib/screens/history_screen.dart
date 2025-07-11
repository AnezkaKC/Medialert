import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text('Historial'),
          ],
        ),
      ),
      body: const Center(
        child: Text('Aquí se mostrará el historial.'),
      ),
    );
  }
}
