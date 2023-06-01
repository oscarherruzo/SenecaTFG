import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/anadirNuevoAlumnoScreen.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Pantallas/profesoresScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/Provider.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter_intl/flutter_intl.dart';
import 'package:intl/intl.dart';

import 'alumnosScreen.dart';
import 'banioScreen.dart';
import 'convivencia.dart';
import 'daceScreen.dart';

// PANTALLA DE SALIDA
class SalidaScreen extends StatefulWidget {
  @override
  _SalidaScreenState createState() => _SalidaScreenState();
}

class _SalidaScreenState extends State<SalidaScreen> {
  String _selectedCurso = 'Todos';
  List<bool> _acceptButtonStates = [];
  List<DateTime?> _salidaTimes = [];
  bool _isDropdownEnabled = true;
  bool _isEntryMode = false;
  bool _isRedColor = false;

  @override
  Widget build(BuildContext context) {
    // PROVIDER Y LISTA DE ALUMNOS
    final alumnosProvider = Provider.of<ProviderScreen>(context);
    final List<Alumnos> alumnos = alumnosProvider.alumnos;
    alumnosProvider.getUserFromSheet();
    // TIEMPO RECORRIDO
    Map<int, bool> _timerInProgress = {};
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedDate = formatter.format(now);
    // CURSOS
    final List<String> cursos = [
      'Todos',
      '1º ESO',
      '2º ESO',
      '3º ESO',
      '4º ESO',
      '1º Bachiller',
      '2º Bachiller'
    ];

    // Filter the alumnos list based on the selected curso
    final filteredAlumnos = alumnos
        .where((alumno) =>
            alumno.curso == _selectedCurso || _selectedCurso == 'Todos')
        .toList();

    // Initialize button states and salida times for each alumno
    if (_acceptButtonStates.isEmpty) {
      _acceptButtonStates = List<bool>.filled(filteredAlumnos.length, true);
      _salidaTimes = List<DateTime?>.filled(filteredAlumnos.length, null);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Salidas'),
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
                  ListTile(
                    title: Text(_selectedCurso),
                    trailing: Icon(Icons.arrow_drop_down),
                    onTap: () {
                      if (_isEntryMode) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Seleccione un curso'),
                            content: Container(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cursos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final curso = cursos[index];
                                  return ListTile(
                                    title: Text(curso),
                                    onTap: () {
                                      setState(() {
                                        // CURSO SELECCIONADO
                                        _selectedCurso = curso;
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: alumnos.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: filteredAlumnos.length,
                            itemBuilder: (context, index) {
                              // FILTRO PARA SI FILTRAMOS POR CURSO O NO
                              final alumno = filteredAlumnos[index];
                              final acceptButtonEnabled =
                                  _acceptButtonStates[index];
                              final salidaTime = _salidaTimes[index];
                              final entradaTime = DateTime.now();

                              Duration? tiempoFuera;
                              if (salidaTime != null) {
                                tiempoFuera =
                                    entradaTime.difference(salidaTime);
                              }

                              return ListTile(
                                title: Text(
                                  '${alumno.nombre} ${alumno.apellidos}',
                                  textAlign: TextAlign.left,
                                ),
                                trailing: ElevatedButton.icon(
                                  icon: Icon(Icons.check_circle,
                                      color: Colors.white),
                                  label: Text(
                                    acceptButtonEnabled ? 'Salida' : 'Entrada',
                                    style: TextStyle(fontSize: 12),
                                  ),

                                  onPressed: acceptButtonEnabled
                                      ? () {
                                          setState(() {
                                            _acceptButtonStates[index] = false;
                                            _salidaTimes[index] = entradaTime;
                                            _isDropdownEnabled = false;
                                            _isEntryMode = true;
                                          });
                                          // Perform exit action
                                        }
                                      : () async {
                                          setState(() {
                                            _acceptButtonStates[index] = true;
                                            _salidaTimes[index] = null;
                                            _isDropdownEnabled = true;
                                            _isEntryMode = false;
                                          });
                                          // SPREADSHEET ID
                                          final String spreadsheetID =
                                              '1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw';
                                          // CRENDECIALES
                                          final credenciales = {
                                            "type": "service_account",
                                            "project_id": "senecatfg",
                                            "private_key_id":
                                                "56a21047f511cba37f50da836a22e1a5bfc662e5",
                                            "private_key":
                                                "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDgKV/GB5FZJFYF\nsIyuOHVPypMCmhD+SwS9nh+KWF4u/ro2S8AhZXw38GIkxjTpZatBsOiSYoSCFcKI\nfndlsoAgCKMb3a9eF4hFypFkqTqoBwE4SYypyHxwZf6vaGUYTareG7FI3PRiDhwA\n9fx4XYZY/NpCSfCIxLpisaHIWiG8VpI4aE4voOfqcMtNWHeDwmn7pdqD9Opb0To9\nejN3uFIZk10OhdLnT4M85+dmU4m8kUFJQQ5eV38WZ6eXV0jk625sNTBWwhwJG+x+\neGRCvjPx2bQX7CcHfi+pEkVaCwKRGuGZTmsot1qxrcnLKEZmAevqUIfvGAMGnm73\n/6RbdN7DAgMBAAECggEAFMWgu2AOJv2H/yT6FFblAAzcjJwsQPRArzWM5KwFpkMy\njD9+wVl/JkvfPFslog8qzH6RPqdkcg2EJlPZypG877r9KmLjkkuJ9DWuPW61Icbs\nZQPjxgPvDBdXf3ekDpl74PMd/YuEFeYK0Ef7Kkg4X9ymeQgTAwl/4A9n14IKqEIN\nCqNTkYvbVVWH5DCb09qDhJCHBl/tBUaAsQtWn8Wl+hO9PCWPyXned5XZVKwi4hcO\n2xWygdB499+7FGLfBBsKiL8kOAjGnuX75Dc19ybgRpHUja9faSTDxd5G0N5ZM2l3\nHWUTRC3sBawgZJqfp/Rjk+6vUQrTdF6ZgksBteDkwQKBgQDxlYl9o7Bjnxa9zY/8\nZKXgHJNErM5vTyd3kPjULvBqyWVIdTQQ8184Cz7tGvVSNLOPkz8X3teyyRK/m4OF\n5lEpYSJc16fYrjGvDRwtktD8192JaN2KlBNzqXqbwH2+Dnr4qQy8Xu1VdRJ8L6HG\nhmmKi560/G09LGXdzbTAmxqMowKBgQDtibBlBIYKlpod826buqUEUymIxuGK5AwF\nt6zDLyPPNnpoZ8wXOnn4bUtbkDpHSWWEGDPj4vunsq6chgJos7wtMXJ5faCfLgmy\nEu5wAEdHpi8gH6cpZDEn4qw/MpAsXcEQECizKVgHMWMxlivQ05RacXEmTCdQ/m3F\nMADzpfBnYQKBgQDSDkv2SpXciT+k2VARDRKNw0rps7frYM/YTt2M4SN6NpMyZXZY\nJsTsXhrg30ffqqNWe5moj8LNWbhLklTR4GlBqYvPXlQ7O3tH0gZmOfotXyTpjZzU\nGdyv/PT26HBtCPozrAm+4GtMmvbvtBreG5E5Ph1JEROK1UfdjDdWIYb8MQKBgHlB\n03EN6RsYnB3z+Z+3nKtjhI1U8SfEmDqG88NDmiUaK0yGyBGHgWIG8PQR4R4o4pCX\nBk4rvclyll5CrpIiRkpPtp88OTVo+/wSW/OCwOBbfi0I231urwUsWj98oUp0pax8\ngzpKPayWUouqnD1i9JVi2Z7yOxPGfeSuR54ZNGqhAoGBAOSRhTmYwyz5CrEe0JPL\nC2DpFTcnhMCHBz2U0jaGAM8mwZBRnvD+xd47FvQHqEk6aTaT8fo3cI3dk1O08ZVt\nEBUxW5pPr/uqBzHJhCkAfXshkKW1JHNx1MQ5s1aCXqX40qTAJ/MChoOxt0CKU/6X\nFaNqL3GJt45U/by6aYnyJQ6h\n-----END PRIVATE KEY-----\n",
                                            "client_email":
                                                "oscartfg@senecatfg.iam.gserviceaccount.com",
                                            "client_id":
                                                "115965778508200535757",
                                            "auth_uri":
                                                "https://accounts.google.com/o/oauth2/auth",
                                            "token_uri":
                                                "https://oauth2.googleapis.com/token",
                                            "auth_provider_x509_cert_url":
                                                "https://www.googleapis.com/oauth2/v1/certs",
                                            "client_x509_cert_url":
                                                "https://www.googleapis.com/robot/v1/metadata/x509/oscartfg%40senecatfg.iam.gserviceaccount.com"
                                          };

                                          final gsheets = GSheets(credenciales);
                                          final ss = await gsheets
                                              .spreadsheet(spreadsheetID);
                                          // HOJA A REALIZAR EL INSER
                                          final sheet =
                                              ss.worksheetByTitle('Entrada');
                                          // INSERT
                                          final insertRow =
                                              sheet?.values.appendRow([
                                            alumno.nombre +
                                                ' ' +
                                                alumno.apellidos,
                                            alumno.curso,
                                            tiempoFuera != null
                                                ? '${tiempoFuera.inMinutes}m ${tiempoFuera.inSeconds % 60}s'
                                                : '',
                                            formattedDate
                                          ]);
                                          // INDICAMOS SI SE INSERTAN BIEN O NO
                                          if (insertRow != null) {
                                            // Inserción exitosa
                                            print(
                                                'Datos insertados correctamente.');
                                          } else {
                                            // Error en la inserción
                                            print(
                                                'Error al insertar los datos.');
                                          }
                                        },
                                  // CAMBIAMOS EL ESTADO SEGUN SE PULSE O NO, VERDE O ROJO
                                  style: ElevatedButton.styleFrom(
                                    primary: acceptButtonEnabled
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                subtitle: tiempoFuera != null
                                    ? Text(
                                        // CONTADOR DE TIEMPO
                                        'Tiempo fuera: ${tiempoFuera.inMinutes} min ${tiempoFuera.inSeconds % 60} seg')
                                    : null,
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
}
