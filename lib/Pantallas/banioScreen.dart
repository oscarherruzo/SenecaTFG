import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/alumnosExpulsados.dart';
import 'package:seneca_tfg/Pantallas/informesScreen.dart';
import 'package:seneca_tfg/Pantallas/mayoresScreen.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Pantallas/profesoresScreen.dart';
import 'package:seneca_tfg/Pantallas/salidaScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/Provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alumnosScreen.dart';
import 'convivencia.dart';
import 'daceScreen.dart';

// CLASE BAÑO
class banioPreviaScreen extends StatefulWidget {
  @override
  _banioPreviaScreen createState() => _banioPreviaScreen();
}

class _banioPreviaScreen extends State<banioPreviaScreen> {
  // OPCION POR DEFECTO PARA ENTRAR
  String _opcionSeleccionada = 'Salida/Entrada';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Menú Baño'),
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
        child: Column(
          children: [
            Expanded(
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
                    title: Text('Menú Principal'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Alumnos'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlumnosScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Personal del Centro'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfesoresScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Convivencia'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConvivenciaScreen()),
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
                        MaterialPageRoute(
                            builder: (context) => banioPreviaScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Ayuda'),
              leading: Icon(Icons.help_outline),
              onTap: () {
                String url =
                    'https://miro.com/app/board/uXjVMDxywRA=/?share_link_id=600263225023';
                _launchURL(url);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
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
                  // COMBOBOX PARA ELEGIR LA OPCION A NAVEGAR
                  DropdownButton<String>(
                    value: _opcionSeleccionada,
                    onChanged: (String? newValue) {
                      setState(() {
                        // DECLARAMOS QUE LA OPCION SELECCIONADA ES NUEVA
                        _opcionSeleccionada = newValue!;
                      });
                    },
                    items: <String>['Salida/Entrada', 'Informes']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  // SEGUN LA OPCION AL PULSAR NOS LLEVA A UNA PANTALLA O OTRA
                  ElevatedButton(
                    onPressed: () {
                      if (_opcionSeleccionada == 'Salida/Entrada') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalidaScreen()));
                      } else if (_opcionSeleccionada == 'Informes') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InformesScreen()));
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

  // METODO PARA ABRIR LA URL, SINO IGNORAMOS QUE ESTAN DEPRECADAS CUANDO HACEMOS EL HOSTING NO NOS ABRE EL ENLACE AUNQUE EN LOCAL SI, SI LAS IGNORAMOS SI LO ABRE SUBIDO
  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }
}
