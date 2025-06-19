// En lib/screens/register_screen.dart (o similar)
import 'package:flutter/material.dart';
import 'package:medialert/models/user.dart';
import 'package:medialert/screens/components/custom_body.dart';
import 'package:medialert/screens/components/input_text.dart';
import 'package:medialert/services/user_storage_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserStorageService _userStorageService = UserStorageService();

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      final newUser = User(
        email: email,
        password: password,
      );

      bool success = await _userStorageService.registerUser(newUser);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Registro exitoso! Ya puedes iniciar sesión.')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El correo electrónico ya está registrado. Por favor, usa otro.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      appBarTittle:'Registro de Usuario',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputText( // <--- Usando tu InputText personalizado
                controller: _emailController,
                labelText: 'Correo electrónico',
                keyboardType: TextInputType.emailAddress,
                validator: (value) { // <--- Aquí pasas la función de validación
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Ingresa un correo electrónico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputText( // <--- Usando tu InputText personalizado
                controller: _passwordController,
                labelText: 'Contraseña',
                obscureText: true,
                validator: (value) { // <--- Aquí pasas la función de validación
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'CREAR CUENTA',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}