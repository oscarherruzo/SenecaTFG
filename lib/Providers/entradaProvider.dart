import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/convivenciaClass.dart';

import 'entradaClass.dart';

// PROVIDER DE ALUMNOS AL BAÑO
class EntradaProvider extends ChangeNotifier {
  late String nombre;
  late String curso;
  late String tiempo;
  late String fecha;
  final List<Entrada> entradasLista = [];

  ConvivenciaProvider() {
    getUserFromSheet();
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=Entrada';

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
      entradasLista.clear();

      // Añadir los nuevos profesores obtenidos de la API
      for (dynamic data in jsonData) {
        Entrada entradas = Entrada(
            nombre: data['Nombre'],
            curso: data['Curso'],
            tiempo: data['Tiempo'],
            fecha: data['Fecha']);

        entradasLista.add(entradas);
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
