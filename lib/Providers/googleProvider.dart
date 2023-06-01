import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seneca_tfg/Providers/googleClass.dart';
import 'package:seneca_tfg/Providers/profesores.dart';

// PROVIDER DE MI LOGIN
class EmailProvider extends ChangeNotifier {
  String? email;
  String? contrasenia;
  final List<googleClass> profesores = [];

  EmailProvider() {
    getUserFromSheet();
  }
  bool isEmailPresent(String email) {
    return profesores.any((profesor) => profesor.mail == email);
  }

  Future<String> _getJsonData() async {
    var url =
        'https://script.google.com/macros/s/AKfycbzp5p-IMzJI1B6Aj5hONf5bfCrGhKNuUia-9Qmg0D5KEv2axojXNPBdNKpfjuLlIcyd/exec?spreadsheetId=1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw&sheet=google';

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

      // Añadir los nuevos profesores obtenidos de la API
      for (dynamic data in jsonData) {
        googleClass emails =
            googleClass(mail: data['Email'], contrasenia: data['Contraseña']);

        profesores.add(emails);
      }

      notifyListeners();
    } on FormatException catch (e) {
      print('Error de formato: $e');
    }
  }
}
