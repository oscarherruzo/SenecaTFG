import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/alumnosExpulsados.dart';
import 'package:seneca_tfg/Pantallas/mayoresScreen.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Pantallas/profesoresScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/Provider.dart';

import 'alumnosScreen.dart';
import 'banioScreen.dart';
import 'daceScreen.dart';

// CONVIVENCIA MENU PANTALLAS
class ConvivenciaScreen extends StatefulWidget {
  @override
  _ConvivenciaScreenState createState() => _ConvivenciaScreenState();
}

class _ConvivenciaScreenState extends State<ConvivenciaScreen> {
  // OPCION POR DEFECTO
  String _selectedOption = 'Expulsados';

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Convivencia Menu'),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        automaticallyImplyLeading:
            false, // Esta línea evita mostrar la flecha de volver
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Alumnos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlumnosScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Personal del Centro'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfesoresScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Convivencia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConvivenciaScreen()),
                );
              },
            ),
            ListTile(
              title: Text('DACE'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DACEScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Baño'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => banioPreviaScreen()),
                );
              },
            ),
          ],
        ),
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
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
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
            height: MediaQuery.of(context).size.height * 0.7,
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
                  // COMBOBOX OPCIONES
                  DropdownButton<String>(
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items: <String>['Expulsados', 'Mayores']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    // NOS MUEVE A UNA PANTALLA O OTRA
                    onPressed: () {
                      if (_selectedOption == 'Expulsados') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => expulsadosScreen()));
                      } else if (_selectedOption == 'Mayores') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MayoresScreen()));
                      }
                    },
                    child: Text('Aceptar'),
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
