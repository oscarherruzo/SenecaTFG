import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// CLASE AÑADIR ALUMNO
class anadirAlumno extends StatelessWidget {
  // VARIABLES PARA RECOGER BIEN LOS DATOS DE LOS INPUT, SI NO SE HACE ASI NO INSERTA TODOS LOS CAMPOS Y FALLAN ENTRE SI
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _cursoController = TextEditingController();
  final _observacionesController = TextEditingController();
  final _telMadreController = TextEditingController();
  final _telPadreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // PROVIDER Y LISTA DE ALUMNOS
    final alumnosProvider = Provider.of<ProviderScreen>(context);
    final List<Alumnos> alumnos = alumnosProvider.alumnos;
    alumnosProvider.getUserFromSheet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Añadir Nuevo Alumno'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlumnosScreen()),
            );
          },
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
              // FORMULARIO PARA PEDIR LOS DATOS DEL ALUMNO
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        icon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          // DEFINIMOS QUE EL CAMPO EL OBLIGATORIO
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _apellidosController,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        icon: Icon(Icons.person_outline),
                      ),
                      // DEFINIMOS QUE EL CAMPO EL OBLIGATORIO
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // COMBOBOX PARA ELEGIR EL CURSO
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Curso',
                        icon: Icon(Icons.school),
                      ),
                      value: '1º ESO',
                      onChanged: (value) {
                        _cursoController.text = value!;
                      },
                      items: [
                        '1º ESO',
                        '2º ESO',
                        '3º ESO',
                        '4º ESO',
                        '1º Bachillerato',
                        '2º Bachillerato',
                      ].map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _observacionesController,
                      decoration: InputDecoration(
                        labelText: 'Observaciones',
                        icon: Icon(Icons.note),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _telMadreController,
                      decoration: InputDecoration(
                        labelText: 'Teléfono madre',
                        icon: Icon(Icons.phone_android_rounded),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _telPadreController,
                      decoration: InputDecoration(
                        labelText: 'Teléfono padre',
                        icon: Icon(Icons.phone_android_outlined),
                      ),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Añadir Alumno'),
                      // FUNCIONALIDAD
                      onPressed: () async {
                        // SI TODOS LOS CAMPOS ESTAN RELLENOS Y CORRECTOS
                        if (_formKey.currentState!.validate()) {
                          // SPREADSHEET ID
                          final String spreadsheetID =
                              '1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw';
                          // CREDENCIALES
                          final credenciales = {
                            "type": "service_account",
                            "project_id": "senecatfg",
                            "private_key_id":
                                "56a21047f511cba37f50da836a22e1a5bfc662e5",
                            "private_key":
                                "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDgKV/GB5FZJFYF\nsIyuOHVPypMCmhD+SwS9nh+KWF4u/ro2S8AhZXw38GIkxjTpZatBsOiSYoSCFcKI\nfndlsoAgCKMb3a9eF4hFypFkqTqoBwE4SYypyHxwZf6vaGUYTareG7FI3PRiDhwA\n9fx4XYZY/NpCSfCIxLpisaHIWiG8VpI4aE4voOfqcMtNWHeDwmn7pdqD9Opb0To9\nejN3uFIZk10OhdLnT4M85+dmU4m8kUFJQQ5eV38WZ6eXV0jk625sNTBWwhwJG+x+\neGRCvjPx2bQX7CcHfi+pEkVaCwKRGuGZTmsot1qxrcnLKEZmAevqUIfvGAMGnm73\n/6RbdN7DAgMBAAECggEAFMWgu2AOJv2H/yT6FFblAAzcjJwsQPRArzWM5KwFpkMy\njD9+wVl/JkvfPFslog8qzH6RPqdkcg2EJlPZypG877r9KmLjkkuJ9DWuPW61Icbs\nZQPjxgPvDBdXf3ekDpl74PMd/YuEFeYK0Ef7Kkg4X9ymeQgTAwl/4A9n14IKqEIN\nCqNTkYvbVVWH5DCb09qDhJCHBl/tBUaAsQtWn8Wl+hO9PCWPyXned5XZVKwi4hcO\n2xWygdB499+7FGLfBBsKiL8kOAjGnuX75Dc19ybgRpHUja9faSTDxd5G0N5ZM2l3\nHWUTRC3sBawgZJqfp/Rjk+6vUQrTdF6ZgksBteDkwQKBgQDxlYl9o7Bjnxa9zY/8\nZKXgHJNErM5vTyd3kPjULvBqyWVIdTQQ8184Cz7tGvVSNLOPkz8X3teyyRK/m4OF\n5lEpYSJc16fYrjGvDRwtktD8192JaN2KlBNzqXqbwH2+Dnr4qQy8Xu1VdRJ8L6HG\nhmmKi560/G09LGXdzbTAmxqMowKBgQDtibBlBIYKlpod826buqUEUymIxuGK5AwF\nt6zDLyPPNnpoZ8wXOnn4bUtbkDpHSWWEGDPj4vunsq6chgJos7wtMXJ5faCfLgmy\nEu5wAEdHpi8gH6cpZDEn4qw/MpAsXcEQECizKVgHMWMxlivQ05RacXEmTCdQ/m3F\nMADzpfBnYQKBgQDSDkv2SpXciT+k2VARDRKNw0rps7frYM/YTt2M4SN6NpMyZXZY\nJsTsXhrg30ffqqNWe5moj8LNWbhLklTR4GlBqYvPXlQ7O3tH0gZmOfotXyTpjZzU\nGdyv/PT26HBtCPozrAm+4GtMmvbvtBreG5E5Ph1JEROK1UfdjDdWIYb8MQKBgHlB\n03EN6RsYnB3z+Z+3nKtjhI1U8SfEmDqG88NDmiUaK0yGyBGHgWIG8PQR4R4o4pCX\nBk4rvclyll5CrpIiRkpPtp88OTVo+/wSW/OCwOBbfi0I231urwUsWj98oUp0pax8\ngzpKPayWUouqnD1i9JVi2Z7yOxPGfeSuR54ZNGqhAoGBAOSRhTmYwyz5CrEe0JPL\nC2DpFTcnhMCHBz2U0jaGAM8mwZBRnvD+xd47FvQHqEk6aTaT8fo3cI3dk1O08ZVt\nEBUxW5pPr/uqBzHJhCkAfXshkKW1JHNx1MQ5s1aCXqX40qTAJ/MChoOxt0CKU/6X\nFaNqL3GJt45U/by6aYnyJQ6h\n-----END PRIVATE KEY-----\n",
                            "client_email":
                                "oscartfg@senecatfg.iam.gserviceaccount.com",
                            "client_id": "115965778508200535757",
                            "auth_uri":
                                "https://accounts.google.com/o/oauth2/auth",
                            "token_uri": "https://oauth2.googleapis.com/token",
                            "auth_provider_x509_cert_url":
                                "https://www.googleapis.com/oauth2/v1/certs",
                            "client_x509_cert_url":
                                "https://www.googleapis.com/robot/v1/metadata/x509/oscartfg%40senecatfg.iam.gserviceaccount.com"
                          };
                          // PASAMOS LAS CREDENCIALES
                          final gsheets = GSheets(credenciales);
                          // PASAMOS EL ID DE LA HOJA
                          final ss = await gsheets.spreadsheet(spreadsheetID);
                          // TITULO DE LA HOJA A INSERTAR
                          var sheet = ss.worksheetByTitle('alumnos');
                          // LO INSERTAMOS CON UN APPEND ROW, EN CASO DE QUE SE QUIERA CON UN SCRIPT DA FALLO POR CONFLICTOS Y NO SE PUEDE REALIZAR BIEN
                          await sheet?.values.appendRow([
                            _nombreController.text,
                            _apellidosController.text,
                            _cursoController.text,
                            _observacionesController.text,
                            _telMadreController.text,
                            _telPadreController.text
                          ]);
                          // LIMPIAMOS LOS CAMPOS DE TEXTO
                          _nombreController.clear();
                          _apellidosController.clear();
                          _cursoController.clear();
                          _observacionesController.clear();
                          _telMadreController.clear();
                          _telPadreController.clear();
                          // SNACKBAR PARA INDICAR QUE TODO SE HA INSERTADO BIEN
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Alumno añadido correctamente'),
                            ),
                          );
                        }
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
