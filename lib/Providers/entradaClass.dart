import 'dart:convert';

// CLASE DE ENTRADA DE ALUMNOS
class Entrada {
  Entrada({
    required this.nombre,
    required this.curso,
    required this.tiempo,
    required this.fecha,
  });

  String nombre;
  String curso;
  String tiempo;
  String fecha;

  factory Entrada.fromJson(String str) => Entrada.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Entrada.fromMap(Map<String, dynamic> json) => Entrada(
        nombre: json["Nombre"],
        curso: json["Curso"],
        tiempo: json["Tiempo"],
        fecha: json['Fecha'],
      );

  Map<String, dynamic> toMap() =>
      {"Nombre": nombre, "Curso": curso, "Tiempo": tiempo, "Fecha": fecha};
}
