import 'package:flutter/material.dart';
import '../models/medicine.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Medicine> _medicines = [];

  void _addOrEditMedicine(Medicine? med) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddMedicineScreen(medicine: med),
      ),
    );

    if (result != null && result is Medicine) {
      setState(() {
        if (med != null) {
          final index = _medicines.indexWhere((m) => m.id == med.id);
          _medicines[index] = result;
        } else {
          _medicines.add(result);
        }
      });
    }
  }

  void _deleteMedicine(String id) {
    setState(() {
      _medicines.removeWhere((m) => m.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Medicamentos'),
      ),
      body: _medicines.isEmpty
          ? const Center(child: Text('No hay medicamentos añadidos.'))
          : ListView.builder(
              itemCount: _medicines.length,
              itemBuilder: (context, index) {
                final med = _medicines[index];
                return ListTile(
                  title: Text('${med.name} - ${med.dose}'),
                  subtitle: Text(
                      'Hora: ${med.time.format(context)}\nDías: ${med.days.join(', ')}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _addOrEditMedicine(med),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteMedicine(med.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditMedicine(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
