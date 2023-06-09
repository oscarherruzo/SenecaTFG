import 'package:meta/meta.dart';
import 'dart:convert';

// CLASE DE ALUMNOS
class Alumnos {
  Alumnos(
      {required this.nombre,
      required this.apellidos,
      required this.curso,
      required this.observaciones,
      required this.telMadre,
      required this.telPadre});

  String nombre;
  String apellidos;
  String curso;
  String observaciones;
  String telMadre;
  String telPadre;

  factory Alumnos.fromJson(String str) => Alumnos.fromMap(json.decode(str));
  String alumnosToJson() => json.encode(toJson());

  factory Alumnos.fromMap(Map<String, dynamic> json) => Alumnos(
      nombre: json["Nombre"],
      apellidos: json["Apellidos"],
      curso: json["Curso"],
      observaciones: json["Observaciones"],
      telMadre: json["telMadre"],
      telPadre: json["telPadre"]);

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Apellidos": apellidos,
        "Curso": curso,
        "Observaciones": observaciones,
        "telMadre": telMadre,
        "telPadre": telPadre
      };

  static void addAlumno({
    required String nombre,
    required String apellidos,
    required String curso,
    required String observaciones,
    required String telMadre,
    required String telPadre,
    required List<Alumnos> listaAlumnos,
  }) {
    final nuevoAlumno = Alumnos(
        nombre: nombre,
        apellidos: apellidos,
        curso: curso,
        observaciones: observaciones,
        telMadre: telMadre,
        telPadre: telPadre);
    listaAlumnos.add(nuevoAlumno);
  }
}
