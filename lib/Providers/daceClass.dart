import 'dart:convert';

// CLASE DE DACE
class DACEClass {
  DACEClass({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.enlace,
  });

  String nombre;
  String fechaInicio;
  String fechaFin;
  String enlace;

  factory DACEClass.fromJson(String str) => DACEClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DACEClass.fromMap(Map<String, dynamic> json) => DACEClass(
        nombre: json["Nombre"],
        fechaInicio: json["FechaInicio"],
        fechaFin: json["FechaFin"],
        enlace: json["Enlace"],
      );

  Map<String, dynamic> toMap() => {
        "Nombre": nombre,
        "FechaInicio": fechaInicio,
        "FechaFin": fechaFin,
        "Enlace": enlace,
      };

  static void addDACE({
    required String nombre,
    required String fechaInicio,
    required String fechaFin,
    required String enlace,
    required List<DACEClass> daceLista,
  }) {
    final dace = DACEClass(
      nombre: nombre,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
      enlace: enlace,
    );
    daceLista.add(dace);
  }
}
