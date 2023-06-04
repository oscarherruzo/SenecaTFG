import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/expulsionAnadir.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Pantallas/profesoresScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/ExpulsadosProvider.dart';
import 'package:seneca_tfg/Providers/Provider.dart';
import 'package:seneca_tfg/Providers/alumnoExpulsado.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alumnosScreen.dart';
import 'banioScreen.dart';
import 'convivencia.dart';
import 'daceScreen.dart';

// CLASE EXPULSADOS
class expulsadosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PROVIDER EXPULSADOS
    final expulsadosProvider = Provider.of<providerExpulsados>(context);
    final List<expulsadoAlumno> alumnosExpulsados =
        Provider.of<providerExpulsados>(context).alumnos;
    expulsadosProvider.getUserFromSheet();
// SCAFFOLD
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Expulsados'),
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExpulsadosInsertScreen()),
              );
            },
          ),
        ],
      ),
      // DRAWER O MENÚ HAMBURGUESA
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
                      // IMAGEN DE ISENECA ENCIMA DEL STACK
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
                  child: const Center(
                    child: Text(
                      'Lista de profesores',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // POSICION DE LA IMAGEN DE ISENECA CON MEDIA QUERY
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
                  // MOSTRAR EN UNA FILA AL ALUMNO EXPULSADO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Nombre',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Curso',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Fecha',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    // CIRCULAR PROGRESS INDICATOR
                    child: alumnosExpulsados.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: alumnosExpulsados.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        // NOMBRE
                                        // ignore: unnecessary_string_interpolations
                                        '${alumnosExpulsados[index].nombre}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        // CURSO
                                        // ignore: unnecessary_string_interpolations
                                        '${alumnosExpulsados[index].curso}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        // FECHA
                                        // ignore: unnecessary_string_interpolations
                                        '${alumnosExpulsados[index].fecha}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          // IMAGEN ABAJO DE LA DERECHA DEL STACK
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
