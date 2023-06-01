import 'package:meta/meta.dart';
import 'dart:convert';

// CLASE DE ALUMNOS EXPULSADOS
class expulsadoAlumno {
  expulsadoAlumno({
    required this.nombre,
    required this.curso,
    required this.fecha,
  });

  String nombre;

  String curso;
  String fecha;

  factory expulsadoAlumno.fromJson(String str) =>
      expulsadoAlumno.fromMap(json.decode(str));
  String alumnosToJson() => json.encode(toJson());

  factory expulsadoAlumno.fromMap(Map<String, dynamic> json) => expulsadoAlumno(
        nombre: json["Nombre"],
        curso: json["Curso"],
        fecha: json["Fecha"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Curso": curso,
        "Fecha": fecha,
      };

  static void addAlumno({
    required String nombre,
    required String curso,
    required String fecha,
    required List<expulsadoAlumno> listaAlumnos,
  }) {
    final nuevoAlumno = expulsadoAlumno(
      nombre: nombre,
      curso: curso,
      fecha: fecha,
    );
    listaAlumnos.add(nuevoAlumno);
  }
}
