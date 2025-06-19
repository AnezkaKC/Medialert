// login screen
import 'package:flutter/material.dart';
import 'package:medialert/screens/components/custom_body.dart';
import 'package:medialert/screens/components/custom_button.dart';
import 'package:medialert/screens/components/input_text.dart';
import 'package:medialert/services/user_storage_service.dart'; // <--- Importa tu UserStorageService
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
  // GlobalKey para el formulario, necesario para la validación
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController(); // Cambiado a email
  final TextEditingController _passwordController = TextEditingController();

  // Instancia de tu servicio de almacenamiento de usuarios
  final UserStorageService _userStorageService = UserStorageService();

  // Función asíncrona para manejar el inicio de sesión
  Future<void> _login() async {
    // Validar el formulario antes de intentar iniciar sesión
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      // Intentar autenticar al usuario usando el servicio
      final user = await _userStorageService.authenticateUser(email, password);

      if (user != null) {
        // Autenticación exitosa
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Inicio de sesión exitoso!')),
        );
        // Navegar a la pantalla principal (MainScreen)
        // Puedes pasar el objeto 'user' completo si MainScreen lo necesita
        Navigator.pushReplacement( // Usar pushReplacement para no permitir volver a la pantalla de login
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(username: user.email), // Pasamos el email como "username" temporalmente
          ),
        );
      } else {
        // Autenticación fallida
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo o contraseña incorrectos.')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Limpiar los controladores cuando el widget se destruye
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form( // <--- Envuelve tu contenido con Form
            key: _formKey, // <--- Asigna el GlobalKey al Form
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

                InputText(
                  controller: _emailController, // <--- Cambiado a _emailController
                  labelText: 'Correo electrónico', // <--- Cambiado el label
                  keyboardType: TextInputType.emailAddress, // <--- Teclado para email
                  validator: (value) { // <--- Agregando el validador
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo electrónico';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Ingresa un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputText(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  obscureText: true,
                  validator: (value) { // <--- Agregando el validador
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
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
                const SizedBox(height: 20),
                CustomButton(text: 'Iniciar sesión', onPressed: _login), // Llama a la función _login actualizada
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}