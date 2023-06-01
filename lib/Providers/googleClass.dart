import 'dart:convert';
import 'package:flutter/material.dart';

// CLASE PARA MI LOGIN
class googleClass {
  googleClass({required this.mail, required this.contrasenia});

  String mail;
  String contrasenia;

  factory googleClass.fromJson(String str) =>
      googleClass.fromMap(json.decode(str));
  String profesoresToJson() => json.encode(toJson());

  factory googleClass.fromMap(Map<String, dynamic> json) =>
      googleClass(mail: json["Email"], contrasenia: json["Contraseña"]);

  Map<String, dynamic> toJson() => {"Email": mail, "Contraseña": contrasenia};

  static void addProfesor({
    required String mail,
    required String contrasenia,
    required List<googleClass> emails,
  }) {
    final emailscomprobar = googleClass(
      mail: mail,
      contrasenia: contrasenia,
    );
    emails.add(emailscomprobar);
  }
}
