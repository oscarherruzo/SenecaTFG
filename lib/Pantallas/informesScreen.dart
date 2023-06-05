import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// Clase para almacenar la información del informe
class Informe {
  final String nombre;
  final int vecesSalida;
  final String fecha;

  Informe({
    required this.fecha,
    required this.nombre,
    required this.vecesSalida,
  });
}

// PANTALLA DE MIS INFORMES

class InformesScreen extends StatefulWidget {
  @override
  _InformesScreenState createState() => _InformesScreenState();
}

class _InformesScreenState extends State<InformesScreen> {
  DateTime? fechaInicio;
  DateTime? fechaFin;
  List<Informe> informesFiltrados = [];

  @override
  Widget build(BuildContext context) {
    // Determinar si es un dispositivo móvil
    final isMobile = MediaQuery.of(context).size.width < 600;
    final alumnosProvider = Provider.of<EntradaProvider>(context);
    final List<Entrada> alumnos = alumnosProvider.entradasLista;
    alumnosProvider.getUserFromSheet();

    // Contador de salidas de los alumnos
    Map<String, int> contadorSalidas = {};

    // Recorrer la lista de alumnos y contar las salidas
    for (var alumno in alumnos) {
      if (contadorSalidas.containsKey(alumno.nombre)) {
        contadorSalidas[alumno.nombre] = contadorSalidas[alumno.nombre]! + 1;
      } else {
        contadorSalidas[alumno.nombre] = 1;
      }
    }

    // Crear la lista de informes
    List<Informe> informes = contadorSalidas.entries.map((entry) {
      return Informe(
        nombre: entry.key,
        vecesSalida: entry.value,
        fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
    }).toList();

    // Ordenar la lista de informes de mayor a menor cantidad de salidas
    informes.sort((a, b) => b.vecesSalida.compareTo(a.vecesSalida));

    // Filtrar los informes por fecha
    informesFiltrados = informes.where((informe) {
      if (fechaInicio != null && fechaFin != null) {
        DateTime informeDate = DateTime.parse(informe.fecha);
        return informeDate.isAfter(fechaInicio!) &&
            informeDate.isBefore(fechaFin!);
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Informes'),
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
                child: Container(color: Colors.white, child: Column()),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: informesFiltrados.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            informesFiltrados[index].nombre,
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 20,
                            ),
                          ),
                          subtitle: Text(
                            'Salidas: ${informesFiltrados[index].vecesSalida}',
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 20,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Acción cuando se selecciona un informe
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
