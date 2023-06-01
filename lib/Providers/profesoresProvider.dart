import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/profesores.dart';
import 'package:intl/intl.dart';

// PROVIDER DE PROFESORES
class providerProfesores extends ChangeNotifier {
  final List<ProfesoresClase> profesores = [];

  provider() {
    getUserFromSheet();
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=Profesores';

    try {
      final response = await http.get(Uri.parse(url));
      return response.body;
    } on http.ClientException catch (e) {
      print('Error de conexión: $e');
      return '';
    }
  }

  getUserFromSheet() async {
    try {
      final jsonData = jsonDecode(await _getJsonData());

      // Limpiar la lista de profesores
      profesores.clear();

      for (dynamic data in jsonData) {
        ProfesoresClase profesor = ProfesoresClase(
          nombre: data["Nombre"],
          apellidos: data["Apellidos"],
          mail: data["Mail"],
          telefono: data["Teléfono"],
          horario: data["Horario"],
          lunes: data["Lunes"],
          martes: data["Martes"],
          miercoles: data["Miércoles"],
          jueves: data["Jueves"],
          viernes: data["Viernes"],
        );

        profesores.add(profesor);
      }

      // Ordenar la lista alfabéticamente por nombre
      profesores.sort((a, b) => a.nombre.compareTo(b.nombre));

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
