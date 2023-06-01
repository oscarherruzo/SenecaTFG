import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Providers/ProfesoresClase.dart';
import 'package:seneca_tfg/Providers/profesores.dart';
import 'package:seneca_tfg/Providers/profesoresProvider.dart';
import 'package:seneca_tfg/Providers/ubicacionProvider.dart';

import 'alumnosScreen.dart';
import 'banioScreen.dart';
import 'convivencia.dart';
import 'daceScreen.dart';

// PANTALLA PARA PROFESORES
class ProfesoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PROVIDER Y LISTA DE PROFESORES
    final profesoresProvider = Provider.of<providerProfesores>(context);
    final profesores = Provider.of<providerProfesores>(context).profesores;
    profesoresProvider.getUserFromSheet();
    // PROVIDER DE UBICACION
    final ubicacionProvider = Provider.of<UbicacionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Profesores'),
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
                      'Lista de profesores',
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'E-Mail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          'Teléfono',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Más Información',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: profesores.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: profesores.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${profesores[index].mail}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${profesores[index].telefono}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.content_paste),
                                      label: Text('+Info'),
                                      onPressed: () {
                                        // SHOW DIALOG IGUAL QUE ALERT DIALOG
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Información del profesor'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // CAMPOS QUE NOS PIDE JUNTO AL HORARIO
                                                  Text(
                                                      'Nombre: ${profesores[index].nombre} ${profesores[index].apellidos}'),
                                                  Text(
                                                      'E-Mail: ${profesores[index].mail}'),
                                                  Text(
                                                      'Teléfono: ${profesores[index].telefono}'),
                                                  Text(
                                                      'Horario: ${profesores[index].horario}'),
                                                  Text('Ubicación: '),
                                                  Text(
                                                      'Lunes: \n${profesores[index].lunes}'),
                                                  Text(
                                                      'Martes:\n ${profesores[index].martes}'),
                                                  Text(
                                                      'Miércoles: \n${profesores[index].miercoles}'),
                                                  Text(
                                                      'Jueves:\n ${profesores[index].jueves}'),
                                                  Text(
                                                      'Viernes:\n ${profesores[index].viernes}'),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cerrar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    height: 10,
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