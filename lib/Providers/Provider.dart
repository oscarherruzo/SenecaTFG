import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:intl/intl.dart';

// PROVIDER DE ALUMNOS
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

  Future<void> sendDataToGoogleSheet(String nombre, String apellidos,
      String curso, String observaciones) async {
    final url =
        'https://script.google.com/macros/s/AKfycbxLg3bsWcLMKlUl7vb18qiXTDswkH-HXdIQEhO9r72nP3w4NxQmOBSIO3pmhgD26y5d/exec';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'spreadsheetId': '1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw',
        'sheet': 'alumnos',
        'Nombre': nombre,
        'Apellidos': apellidos,
        'Curso': curso,
        'Observaciones': observaciones,
      },
    );

    if (response.statusCode == 200) {
      print('Datos enviados correctamente a Google Sheets');
    } else {
      print(
          'Error al enviar datos a Google Sheets. Código de estado: ${response.statusCode}');
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
          observaciones: data['Observaciones'],
        );

        alumnos.add(alumno);
      }

      // Ordenar la lista alfabéticamente por nombre
      alumnos.sort((a, b) => a.nombre.compareTo(b.nombre));

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
