import 'package:flutter/material.dart';

// Change to StatefulWidget and connect to its state
class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  RecoverPasswordScreenState createState() => RecoverPasswordScreenState();
}

class RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _message = '';

  void _recoverPassword() {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _message = 'Por favor, ingrese su nombre de usuario.';
      });
      return;
    }

    // Simulación de recuperación de contraseña
    setState(() {
      _message =
          'Si el usuario "$username" está registrado, se enviará un enlace para restablecer la contraseña.';
    });

    // Aquí podrías agregar lógica para enviar un email u otra acción.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese su nombre de usuario',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _recoverPassword,
              child: const Text('Recuperar'),
            ),
            const SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
