import 'dart:convert';
import 'package:flutter/material.dart';

// CLASE DE PROFESORES CON HORARIO
class ProfesoresClase {
  ProfesoresClase({
    required this.mail,
    required this.telefono,
    required this.horario,
    required this.nombre,
    required this.apellidos,
    required this.lunes,
    required this.martes,
    required this.miercoles,
    required this.jueves,
    required this.viernes,
  });

  String mail;
  String telefono;
  String horario;
  String nombre;
  String apellidos;
  String lunes;
  String martes;
  String miercoles;
  String jueves;
  String viernes;

  factory ProfesoresClase.fromJson(String str) =>
      ProfesoresClase.fromMap(json.decode(str));
  String profesoresToJson() => json.encode(toJson());

  factory ProfesoresClase.fromMap(Map<String, dynamic> json) => ProfesoresClase(
        mail: json["Mail"],
        telefono: json["Teléfono"],
        horario: json["Horario"],
        nombre: json["Nombre"],
        apellidos: json["Apellidos"],
        lunes: json["Lunes"],
        martes: json["Martes"],
        miercoles: json["Miércoles"],
        jueves: json["Jueves"],
        viernes: json["Viernes"],
      );

  Map<String, dynamic> toJson() => {
        "Mail": mail,
        "Teléfono": telefono,
        "Horario": horario,
        "Nombre": nombre,
        "Apellidos": apellidos,
        "Lunes": lunes,
        "Martes": martes,
        "Miércoles": miercoles,
        "Jueves": jueves,
        "Viernes": viernes,
      };

  static void addProfesor({
    required String mail,
    required String telefono,
    required String horario,
    required String nombre,
    required String apellidos,
    required String lunes,
    required String martes,
    required String miercoles,
    required String jueves,
    required String viernes,
    required List<ProfesoresClase> listaProfesores,
  }) {
    final nuevoProfesor = ProfesoresClase(
      mail: mail,
      telefono: telefono,
      horario: horario,
      nombre: nombre,
      apellidos: apellidos,
      lunes: lunes,
      martes: martes,
      miercoles: miercoles,
      jueves: jueves,
      viernes: viernes,
    );
    listaProfesores.add(nuevoProfesor);
  }
}
