import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/ubicacion.dart';
import 'package:seneca_tfg/Providers/daceClass.dart';

// PROVIDER DE DACE
class DACEProvider extends ChangeNotifier {
  List<DACEClass> daceLista = [];

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=DACE';

    try {
      final response = await http.get(Uri.parse(url));
      return response.body;
    } catch (e) {
      print('Error de conexión: $e');
      return '';
    }
  }

  Future<void> getDACEFromSheet() async {
    try {
      final jsonData = jsonDecode(await _getJsonData());

      // Limpiar la lista de actividades DACE
      daceLista.clear();

      for (dynamic data in jsonData) {
        String nombre = data['Nombre'];
        String fechaInicio = data['FechaInicio'];
        String fechaFin = data['FechaFin'];
        String enlace = data['Enlace'];

        DACEClass.addDACE(
          nombre: nombre,
          fechaInicio: fechaInicio,
          fechaFin: fechaFin,
          enlace: enlace,
          daceLista: daceLista,
        );
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
