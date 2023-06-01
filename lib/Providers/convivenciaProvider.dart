import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/convivenciaClass.dart';

// PROVIDER DE CONVIVENCIA
class ConvivenciaProvider extends ChangeNotifier {
  String? alumno;
  String? curso;
  String? aula;
  String? periodo;
  String? mail;
  String? telefono;
  final List<ConvivenciaClass> mayoresLista = [];

  ConvivenciaProvider() {
    getUserFromSheet();
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=Convivencia';

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
      mayoresLista.clear();

      // Añadir los nuevos profesores obtenidos de la API
      for (dynamic data in jsonData) {
        ConvivenciaClass convivencia = ConvivenciaClass(
          alumno: data['Alumno'],
          curso: data['Curso'],
          aula: data['Aula'],
          periodo: data['Periodo'],
          mail: data['Mail'],
          telefono: data['Teléfono'],
        );

        mayoresLista.add(convivencia);
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
