import 'package:flutter/material.dart';
import 'package:seneca_tfg/Pantallas/alumnosExpulsados.dart';
import 'package:seneca_tfg/Pantallas/alumnosScreen.dart';
import 'package:seneca_tfg/Pantallas/banioScreen.dart';
import 'package:seneca_tfg/Pantallas/convivencia.dart';
import 'package:seneca_tfg/Pantallas/daceScreen.dart';
import 'package:seneca_tfg/Pantallas/profesoresScreen.dart';

// PANTALLA DE MENU
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Menú'),
        centerTitle: true,
        // DESACTIVAMOS LA FLECHA DE VOLVER
        automaticallyImplyLeading: false,
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
                      width: MediaQuery.of(context).size.width,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // NAVEGAMOS A LA PANTALLA DE ALUMNOS
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
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text(
                              'Alumnado del Centro',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // NAVEGAMOS A LA PANTALLA DE PROFESORES
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfesoresScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/profesor.png',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text(
                              'Personal del Centro',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // NAVEGAMOS A LA PANTALLA DE CONVIVENCIA
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConvivenciaScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/covid.png',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text(
                              'Convivencia',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                              'assets/campana.png',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text(
                              'DACE',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
                                  builder: (context) => banioPreviaScreen()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/calendario.png',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                            const Text('Baño',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
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
      ),
    );
  }
}
