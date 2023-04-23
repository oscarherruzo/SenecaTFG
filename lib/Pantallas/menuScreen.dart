import 'package:flutter/material.dart';
import 'package:seneca_tfg/Pantallas/alumnosScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Menú'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              width: 50,
                              height: 50,
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
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/profesor.png',
                              width: 50,
                              height: 50,
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
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/covid.png',
                              width: 50,
                              height: 50,
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
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/campana.png',
                              width: 50,
                              height: 50,
                            ),
                            const Text(
                              'DACE',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/calendario.png',
                              width: 50,
                              height: 50,
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
