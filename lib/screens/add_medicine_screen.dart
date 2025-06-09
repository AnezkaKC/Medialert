// add medicine screen
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/medicine.dart';

class AddMedicineScreen extends StatefulWidget {
  final Medicine? medicine;
  const AddMedicineScreen({super.key, this.medicine});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<String> _selectedDays = [];

  final List<String> _daysOfWeek = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) {
      _nameController.text = widget.medicine!.name;
      _doseController.text = widget.medicine!.dose;
      _selectedTime = widget.medicine!.time;
      _selectedDays = List.from(widget.medicine!.days);
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _saveMedicine() {
    if (_formKey.currentState!.validate()) {
      final med = Medicine(
        id: widget.medicine?.id ?? const Uuid().v4(),
        name: _nameController.text,
        dose: _doseController.text,
        time: _selectedTime,
        days: _selectedDays,
      );
      Navigator.pop(context, med);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine != null
            ? 'Editar Medicamento'
            : 'Agregar Medicamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                controller: _doseController,
                decoration: const InputDecoration(labelText: 'Dosis'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese una dosis' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Hora:'),
                  const SizedBox(width: 16),
                  Text(_selectedTime.format(context)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _pickTime,
                    child: const Text('Seleccionar Hora'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Días de repetición:'),
              Wrap(
                spacing: 8,
                children: _daysOfWeek.map((day) {
                  final isSelected = _selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (_) => _toggleDay(day),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveMedicine,
                child: Text(widget.medicine != null ? 'Guardar' : 'Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
