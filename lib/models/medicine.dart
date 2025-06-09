import 'package:flutter/material.dart';

class Medicine {
  final String id;
  String name;
  String dose;
  TimeOfDay time;
  List<String> days;

  Medicine({
    required this.id,
    required this.name,
    required this.dose,
    required this.time,
    required this.days,
  });
}
