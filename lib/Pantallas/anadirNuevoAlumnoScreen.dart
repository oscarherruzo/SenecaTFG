import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/Provider.dart';
import 'package:provider/provider.dart';

class anadirAlumno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alumnosProvider = Provider.of<ProviderScreen>(context);
    final List<Alumnos> alumnos = alumnosProvider.alumnos;
    alumnosProvider.getUserFromSheet();

    String nombre = '';
    String apellidos = '';
    String curso = '';
    String observaciones = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Añadir Nuevo Alumno'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue.shade900,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Image.asset(
                      'assets/iseneca.png',
                      width: 2000,
                      height: 350,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Lista de alumnos',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            height: 675,
            bottom: 80,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 50.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.zero,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      icon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      nombre = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                      icon: Icon(Icons.person_outline),
                    ),
                    onChanged: (value) {
                      apellidos = value;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Curso',
                      icon: Icon(Icons.school),
                    ),
                    value: '1º ESO',
                    onChanged: (value) {
                      curso = value!;
                    },
                    items: <String>[
                      '1º ESO',
                      '2º ESO',
                      '3º ESO',
                      '4º ESO',
                      '1º Bachillerato',
                      '2º Bachillerato'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Observaciones*',
                      icon: Icon(Icons.notes),
                    ),
                    onChanged: (value) {
                      observaciones = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (nombre.isNotEmpty &&
                          apellidos.isNotEmpty &&
                          curso.isNotEmpty &&
                          observaciones.isNotEmpty) {
                        // alumnosProvider.addUserToSheet(nombre, apellidos, curso, observaciones);
                      }
                    },
                    child: Text('Añadir'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 60,
            child: Image.asset(
              'assets/iconoJunta.png',
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
