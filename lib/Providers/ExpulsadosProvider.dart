import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/Alumnos.dart';
// PROVIDER DE ALUMNOS EXPULSADOS
import 'alumnoExpulsado.dart';

class providerExpulsados extends ChangeNotifier {
  final List<expulsadoAlumno> alumnos = [];

  provider() {
    getUserFromSheet();
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=Expulsados';

    try {
      final response = await http.get(Uri.parse(url));
      return response.body;
    } on http.ClientException catch (e) {
      print('Error de conexión: $e');
      return '';
    }
  }

// METODO PARA REALIZAR UN MOSTRA A TRASVES DE MI SCRIPT DE GOOGLE, NO FUNCIONA POR EL PLAN DE PAGO
/*
  Future<void> sendDataToGoogleSheet(String nombre, String apellidos,
      String curso, String observaciones) async {
    final url =
        'https://script.google.com/macros/s/AKfycbxLg3bsWcLMKlUl7vb18qiXTDswkH-HXdIQEhO9r72nP3w4NxQmOBSIO3pmhgD26y5d/exec';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'spreadsheetId': '1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw',
        'sheet': 'Expulsados',
        'Nombre': Nombre,
        'Curso': apellidos,
        'Curso': curso,
        'Fecha': observaciones,
      },
    );

    if (response.statusCode == 200) {
      print('Datos enviados correctamente a Google Sheets');
    } else {
      print(
          'Error al enviar datos a Google Sheets. Código de estado: ${response.statusCode}');
    }
  }
*/
  getUserFromSheet() async {
    try {
      final jsonData = jsonDecode(await _getJsonData());

      // Limpiar la lista de alumnos
      alumnos.clear();

      // Añadir los nuevos alumnos obtenidos de la API
      for (dynamic data in jsonData) {
        expulsadoAlumno alumno = expulsadoAlumno(
            nombre: data["Nombre"], curso: data["Curso"], fecha: data["Fecha"]);

        alumnos.add(alumno);
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
