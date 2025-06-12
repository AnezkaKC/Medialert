import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  // 1. Definir los parámetros en el constructor
  final TextEditingController controller; // Requerimos un controller
  final String labelText;                 // Requerimos un labelText
  final bool obscureText;                 // Opcional: para campos de contraseña

  // 2. Constructor de la clase
  // Los parámetros requeridos se marcan con 'required'
  const InputText({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false, // Valor por defecto para obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // 3. Asignar los parámetros a las propiedades del TextField
      controller: controller, // Usamos el controller que se pasa al constructor
      obscureText: obscureText, // Usamos el obscureText que se pasa al constructor
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black87, // Color del texto de entrada
      ),
      decoration: InputDecoration(
        labelText: labelText, // Usamos el labelText que se pasa al constructor
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 121, 121, 121),
          fontWeight: FontWeight.bold,
        ),
        // Borde por defecto (invisible pero con radio)
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        // Borde cuando el campo está enfocado
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        // Borde cuando el campo no está enfocado
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.5), // Color del background
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 24.0), // Padding
      ),
    );
  }
}