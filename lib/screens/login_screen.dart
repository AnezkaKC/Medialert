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
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username == 'usuario' && password == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(username: 'usuario'),
        ),
      );
    } else {
      setState(() {
        error = 'Usuario o contraseña incorrectos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Medialert',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 20),
              ElevatedButton(
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
              ElevatedButton(
                onPressed: () {
                  String usuario = _usernameController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(username: usuario),
                    ),
                  );
                },
                child: const Text('Ingresar'),
              ),
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
    );
  }
}
