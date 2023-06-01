import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/ubicacion.dart';

// PROVIDER DE UBICACION DEL PROFESOR
class UbicacionProvider extends ChangeNotifier {
  Map<String, Ubicacion> ubicaciones = {};

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=ubicacion';

    try {
      final response = await http.get(Uri.parse(url));
      return response.body;
    } catch (e) {
      print('Error de conexión: $e');
      return '';
    }
  }

  Future<void> getUbicacionesFromSheet() async {
    try {
      final jsonData = jsonDecode(await _getJsonData());

      // Limpiar el mapa de ubicaciones
      ubicaciones.clear();

      // Añadir las nuevas ubicaciones obtenidas de la API
      for (dynamic data in jsonData) {
        String profesor = data['Profesor'];
        Ubicacion ubicacion = Ubicacion.fromMap(data);

        ubicaciones[profesor] = ubicacion;
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
