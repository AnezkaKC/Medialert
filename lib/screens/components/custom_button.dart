import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // Propiedades opcionales con valores predeterminados
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor; // Este ya existe, pero ahora lo usaremos como primary
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  // NUEVA PROPIEDAD: secondary (booleano)
  final bool isSecondary; // Para controlar si es el estilo secundario

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.backgroundColor = const Color(0xFF4DC0B7), // Este es el color primario por defecto
    this.borderRadius = 15,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    this.isSecondary = false, // Por defecto, el botón NO es secundario
  });

  @override
  Widget build(BuildContext context) {
    // Definimos el color de fondo basado en la propiedad isSecondary
    final Color buttonBackgroundColor = isSecondary
        ? const Color(0xFF3DA198) // Color si isSecondary es true
        : backgroundColor;        // Color primario si isSecondary es false

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor, // Usamos el color determinado por la lógica
        foregroundColor: Colors.white, // El texto seguirá siendo blanco para ambos
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}