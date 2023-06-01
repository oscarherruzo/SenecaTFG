import 'dart:convert';
import 'package:flutter/material.dart';

// CLASE DE CONVIVENCIA
class ConvivenciaClass {
  ConvivenciaClass(
      {required this.alumno,
      required this.curso,
      required this.aula,
      required this.periodo,
      required this.mail,
      required this.telefono});

  String alumno;
  String curso;
  String aula;
  String periodo;
  String mail;
  String telefono;
  factory ConvivenciaClass.fromJson(String str) =>
      ConvivenciaClass.fromMap(json.decode(str));
  String profesoresToJson() => json.encode(toJson());

  factory ConvivenciaClass.fromMap(Map<String, dynamic> json) =>
      ConvivenciaClass(
        alumno: json["Alumno"],
        curso: json["Curso"],
        aula: json["Aula"],
        periodo: json["Periodo"],
        mail: json["Mail"],
        telefono: json["Teléfono"],
      );

  Map<String, dynamic> toJson() => {
        "Alumno": alumno,
        "Curso": curso,
        "Aula": aula,
        "Periodo": periodo,
        "Mail": mail,
        "Teléfono": telefono,
      };

  static void addMayores({
    required String alumno,
    required String curso,
    required String aula,
    required String periodo,
    required String mail,
    required String telefono,
    required List<ConvivenciaClass> mayoresLista,
  }) {
    final mayores = ConvivenciaClass(
      alumno: 'Alumno',
      aula: 'Aula',
      curso: 'Curso',
      periodo: 'Periodo',
      mail: 'Mail',
      telefono: 'Teléfono',
    );
    mayoresLista.add(mayores);
  }
}
