import 'package:meta/meta.dart';
import 'dart:convert';

// CLASE UBICACION DE PROFESOR POR HORA
class Ubicacion {
  Ubicacion({
    required this.nombre,
    required this.horario8_15,
    required this.horario9_15,
    required this.horario10_15,
    required this.horario11_45,
    required this.horario12_45,
    required this.horario13_45,
  });
  String nombre;
  String horario8_15;
  String horario9_15;
  String horario10_15;
  String horario11_45;
  String horario12_45;
  String horario13_45;

  factory Ubicacion.fromJson(String str) => Ubicacion.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());

  factory Ubicacion.fromMap(Map<String, dynamic> json) => Ubicacion(
        nombre: json["Nombre"],
        horario8_15: json["8:15-9:15"],
        horario9_15: json["9:15-10:15"],
        horario10_15: json["10:15-11:15"],
        horario11_45: json["11:45-12:45"],
        horario12_45: json["12:45-13:45"],
        horario13_45: json["13:45-14:45"],
      );

  Map<String, dynamic> toMap() => {
        "Nombre": nombre,
        "8:15-9:15": horario8_15,
        "9:15-10:15": horario9_15,
        "10:15-11:15": horario10_15,
        "11:45-12:45": horario11_45,
        "12:45-13:45": horario12_45,
        "13:45-14:45": horario13_45,
      };
}
