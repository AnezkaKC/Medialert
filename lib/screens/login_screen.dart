// login screen
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'register_screen.dart';
import 'package:medialert/screens/recover_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? error;

  void _login() {
    String usuario = _usernameController.text.trim();
    String password = _passwordController.text;
    // Aquí puedes agregar tu lógica de autenticación
    if (usuario.isEmpty || password.isEmpty) {
      setState(() {
        error = 'Por favor, ingrese usuario y contraseña.';
      });
      return;
    }
    setState(() {
      error = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(username: usuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF0F0F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo arriba del título
                Image.asset(
                  'assets/logo.png',
                  height: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Medialert',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3DA198),
                  ),
                  onPressed: _login,
                  child: const Text('Iniciar sesión'),
                ),
                if (error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RecoverPasswordScreen()),
                    );
                  },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text('Crear cuenta nueva'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
