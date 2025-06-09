// modelo de medicamento
class Medicamento {
  String nombre;
  int frecuencia;
  String unidad; // 'Horas' o 'Días'
  bool eliminado;

  Medicamento({
    required this.nombre,
    required this.frecuencia,
    required this.unidad,
    this.eliminado = false,
  });

  String get resumen {
    return 'Cada $frecuencia ${unidad.toLowerCase()}';
  }

  // Para mostrar en el resumen de usuario
  String get estado {
    return eliminado ? 'ELIMINADO' : resumen.toUpperCase();
  }
}
