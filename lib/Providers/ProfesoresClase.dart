import 'dart:convert';
import 'package:flutter/material.dart';

// CLASE DE PROFESORES SIN HORARIO ES DECIR LUNES, MARTES...
class ProfesoresClase {
  ProfesoresClase({
    required this.mail,
    required this.telefono,
    required this.horario,
    required this.nombre,
    required this.apellidos,
  });

  String mail;
  String telefono;
  String horario;
  String nombre;
  String apellidos;

  factory ProfesoresClase.fromJson(String str) =>
      ProfesoresClase.fromMap(json.decode(str));
  String profesoresToJson() => json.encode(toJson());

  factory ProfesoresClase.fromMap(Map<String, dynamic> json) => ProfesoresClase(
        mail: json["Mail"],
        telefono: json["Teléfono"],
        horario: json["Horario"],
        nombre: json["Nombre"],
        apellidos: json["Apellidos"],
      );

  Map<String, dynamic> toJson() => {
        "Mail": mail,
        "Teléfono": telefono,
        "Horario": horario,
        "Nombre": nombre,
        "Apellidos": apellidos,
      };

  static void addProfesor({
    required String mail,
    required String telefono,
    required String ubicacion,
    required String horario,
    required String nombre,
    required String apellidos,
    required List<ProfesoresClase> listaProfesores,
  }) {
    final nuevoProfesor = ProfesoresClase(
      mail: mail,
      telefono: telefono,
      horario: horario,
      nombre: nombre,
      apellidos: apellidos,
    );
    listaProfesores.add(nuevoProfesor);
  }
}
