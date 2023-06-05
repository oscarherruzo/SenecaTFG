import 'package:flutter/material.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// PANTALLA DE MENU
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Menú'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      // VALE PARA AJUSTAR EL CONTENIDO
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // PREDEFINIMOS UNA CONDICIÓN PARA SABER CUANDO ES MÓVIL O NO
          // EN ESTE CASO SI EL ANCHO ES POR DEBAJO DE 600 PX
          final esMovil = MediaQuery.of(context).size.width < 600;

          return Stack(
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
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Row(
                          mainAxisAlignment: esMovil
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlumnosScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/sombrero.png',
                                    width: esMovil ? 30 : 50,
                                    height: esMovil ? 30 : 50,
                                  ),
                                  Text(
                                    'Alumnado \ndel Centro',
                                    style: TextStyle(
                                      fontSize: esMovil ? 12 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfesoresScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/profesor.png',
                                    width: esMovil ? 30 : 50,
                                    height: esMovil ? 30 : 50,
                                  ),
                                  Text(
                                    'Personal \ndel Centro',
                                    style: TextStyle(
                                      fontSize: esMovil ? 12 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConvivenciaScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/covid.png',
                                    width: esMovil ? 30 : 50,
                                    height: esMovil ? 30 : 50,
                                  ),
                                  Text(
                                    'Convivencia',
                                    style: TextStyle(
                                      fontSize: esMovil ? 12 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NAVEGAMOS A LA PANTALLA DE DACE
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DACEScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  // ANCHO Y ALTO POR SI ES UN MOVIL
                                  'assets/campana.png',
                                  width: esMovil ? 30 : 50,
                                  height: esMovil ? 30 : 50,
                                ),
                                Text(
                                  'DACE',
                                  style: TextStyle(
                                      // TAMAÑO DE FUENTE POR SI ES UN MOVIL
                                      fontSize: esMovil ? 12 : 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          // NAVEGAMOS A LA PANTALLA DEL MENU DE BAÑO
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          banioPreviaScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/calendario.png',
                                  // ANCHO Y ALTO POR SI ES UN MOVIL
                                  width: esMovil ? 30 : 50,
                                  height: esMovil
                                      // ANCHO Y ALTO POR SI ES UN MOVIL
                                      ? 30
                                      : 50,
                                ),
                                Text('Baño',
                                    style: TextStyle(
                                        fontSize: esMovil
                                            // TAMAÑO DE FUENTE POR SI ES UN MOVIL
                                            ? 12
                                            : 18,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
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
          );
        },
      ),
    );
  }
}
