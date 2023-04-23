import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/Alumnos.dart';

class ProviderScreen extends ChangeNotifier {
  final List<Alumnos> alumnos = [];

  provider() {
    getUserFromSheet();
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=alumnos';

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

      // Limpiar la lista de alumnos
      alumnos.clear();

      // Añadir los nuevos alumnos obtenidos de la API
      for (dynamic data in jsonData) {
        Alumnos alumno = Alumnos(
            nombre: data["Nombre"],
            apellidos: data["Apellidos"],
            curso: data["Curso"],
            observaciones: data['Observaciones']);

        alumnos.add(alumno);
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
