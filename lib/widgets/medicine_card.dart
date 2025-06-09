// widget para mostrar medicamento
import 'package:flutter/material.dart';
import '../models/medicamento.dart';

class MedicineCard extends StatelessWidget {
  final Medicamento medicamento;
  final VoidCallback onDelete;

  const MedicineCard({
    super.key,
    required this.medicamento,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.medication, color: Colors.teal),
        title: Text(
          medicamento.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(medicamento.resumen),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
