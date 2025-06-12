// login screen
import 'package:flutter/material.dart';
import 'package:medialert/screens/components/custom_button.dart';
import 'package:medialert/screens/components/input_text.dart';
import 'main_screen.dart';
import 'register_screen.dart';
import 'package:medialert/screens/recover_password_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: Colors.transparent,
      body: Container(
        // Este Container contendrá el degradado y se expandirá para cubrir la pantalla
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(237, 237, 237, 237),
              Color.fromARGB(255, 175, 175, 175),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                SvgPicture.asset('assets/LOGO.svg', height: 150),
                const Text(
                  'MediAlert',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 6,
                    color: Color.fromARGB(255, 85, 85, 85),
                  ),
                ),
                const SizedBox(height: 40),
                if (error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
                InputText(
                  controller: _usernameController,
                  labelText: 'Usuario',
                ),
                const SizedBox(height: 20),
                InputText(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RecoverPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                const SizedBox(height: 20),
                CustomButton(text: 'Iniciar sesión', onPressed: _login),
                const SizedBox(height: 20),

                CustomButton(
                  text: 'Crear Usuario',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  isSecondary: true,
                ),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
