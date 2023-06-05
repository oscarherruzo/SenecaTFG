import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// PANTALLA MAYORES
class MayoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PROVIDER DE MAYORES Y LISTA
    final mayoresProvider = Provider.of<ConvivenciaProvider>(context);
    final List<ConvivenciaClass> mayores =
        Provider.of<ConvivenciaProvider>(context).mayoresLista;
// Determinar si es un dispositivo móvil
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Mayores'),
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
              // MOSTRAMOS LO QUE NOS PIDE
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Alumno',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Curso',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Aula',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Periodo',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '+ Info',
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: mayores.isEmpty
                        // CIRCULAR PROGRESS INDICATOR MIENTRAS CARGA LOS DATOS
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: mayores.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${mayores[index].alumno}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${mayores[index].curso}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${mayores[index].aula}',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${mayores[index].periodo}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: isMobile ? 12 : 18,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // INFORMACION ADICIONAL EN UN ALERT DIALOG
                                              return AlertDialog(
                                                title: Text('Información'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'E-Mail: ${mayores[index].mail}',
                                                      style: TextStyle(
                                                        fontSize:
                                                            isMobile ? 12 : 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Teléfono: ${mayores[index].telefono}',
                                                      style: TextStyle(
                                                        fontSize:
                                                            isMobile ? 12 : 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // VOLVEMOS A LA PANTALLA CUANDO PULSEMOS CERRAR
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Cerrar'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          '+ Info',
                                          style: TextStyle(
                                            fontSize: isMobile ? 12 : 18,
                                          ),
                                        ),
                                      ),
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
