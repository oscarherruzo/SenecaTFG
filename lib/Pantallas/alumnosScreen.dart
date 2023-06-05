import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// CLASE ALUMNOS
class AlumnosScreen extends StatefulWidget {
  @override
  _AlumnosScreenState createState() => _AlumnosScreenState();
}

class _AlumnosScreenState extends State<AlumnosScreen> {
  // DEFINICIÓN DE VARIABLES
  String _nombreBuscar = '';
  String _cursoSeleccionado = '';

  @override
  Widget build(BuildContext context) {
    // LISTA DE ALUNOS
    final alumnosProvider = Provider.of<ProviderScreen>(context);
    final List<Alumnos> alumnos = Provider.of<ProviderScreen>(context).alumnos;
    alumnosProvider.getUserFromSheet();
    // FILTRO DE ALUMNOS
    final filteredAlumnos = alumnos.where((alumno) {
      final nombreCompleto =
          '${alumno.nombre} ${alumno.apellidos}'.toLowerCase();
      return nombreCompleto.contains(_nombreBuscar.toLowerCase()) &&
          (alumno.curso == _cursoSeleccionado || _cursoSeleccionado.isEmpty);
    }).toList();
    // Determinar si es un dispositivo móvil
    final isMobile = MediaQuery.of(context).size.width < 600;
    // LISTA DE CURSOS
    List<String> cursos = [
      '1º ESO',
      '2º ESO',
      '3º ESO',
      '4º ESO',
      '1º Bachillerato',
      '2º Bachillerato',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Alumnos'),
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
        // DESACTIVAMOS LA FECHA DE VOLVER PARA QUE NO HAGA CONFLICTO CON EL ICONO DEL MENÚ DE HAMBURGUESA
        automaticallyImplyLeading: false,
        actions: [
          // BOTÓN DE + PARA AÑADIR ALUMNOS
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => anadirAlumno()),
              );
            },
          ),
        ],
      ),
      // MENU DE HAMBURGUESA
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
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              // VALOR DEL NOMBRE A BUSCAR
                              _nombreBuscar = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Buscar por nombre',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: _cursoSeleccionado,
                          onChanged: (value) {
                            setState(() {
                              // CURSO SELECCIONADO
                              _cursoSeleccionado = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Filtrar por curso',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: '',
                              child: Text('Todos'),
                            ),
                            ...cursos.map((curso) {
                              return DropdownMenuItem<String>(
                                value: curso,
                                child: Text(
                                  curso,
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 24,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: alumnos.isEmpty
                        ? Center(
                            // CIRCULAR PROGRESS INDICATOR MIENTRAS CARGA LOS DATOS
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            // LONGITUD DE LA LISTA
                            itemCount: filteredAlumnos.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  // MOSTRAMOS NOMBRES Y APELLIDOS DE LOS ALUMNOS FILTRADOS
                                  '${filteredAlumnos[index].nombre} ${filteredAlumnos[index].apellidos}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 24,
                                  ),
                                ),
                                subtitle: Text(
                                  filteredAlumnos[index].curso,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 24,
                                  ),
                                ),
                                // MOSTRAMOS MÁS INFORMACIÓN SOLICITADA DEL ALUMNO EN UN ALERT DIALOG
                                trailing: ElevatedButton.icon(
                                  icon: Icon(Icons.content_paste),
                                  label: Text('+Info'),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(
                                          'Información del alumno',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 14 : 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nombre:',
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${filteredAlumnos[index].nombre}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Apellidos:',
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${filteredAlumnos[index].apellidos}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Curso:',
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${filteredAlumnos[index].curso}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Observaciones:',
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${filteredAlumnos[index].observaciones}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: isMobile ? 12 : 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: ElevatedButton.icon(
                                              icon: Icon(Icons.arrow_back),
                                              label: Text('Cerrar'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
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
