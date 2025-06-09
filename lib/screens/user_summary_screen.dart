// user summary screen
import 'package:flutter/material.dart';
import '../utils/fake_database.dart';
import '../models/medicamento.dart';

class UserSummaryScreen extends StatelessWidget {
  const UserSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estado = FakeDatabase.obtenerEstadoDesempeno();
    final eliminados = FakeDatabase.medicamentos
        .where((m) => m.eliminado)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estado actual: $estado',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            const Text(
              'Medicamentos Eliminados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            eliminados.isEmpty
                ? const Text('No hay medicamentos eliminados.')
                : Expanded(
                    child: ListView.builder(
                      itemCount: eliminados.length,
                      itemBuilder: (context, index) {
                        Medicamento med = eliminados[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                            title: Text(med.nombre),
                            subtitle: Text(med.estado),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
