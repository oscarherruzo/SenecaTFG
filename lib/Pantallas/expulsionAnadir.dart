import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// CLASE AÑADIR ALUMNO
// CLASE PARA AÑADIR ALUMNO EXPULSADO
class ExpulsadosInsertScreen extends StatefulWidget {
  @override
  _InsertScreenState createState() => _InsertScreenState();
}

class _InsertScreenState extends State<ExpulsadosInsertScreen> {
  // CONTROLADORES PARA NUESTROS CAMPOS
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cursoController = TextEditingController();
  // FECHA A ELEGIR PARA AÑADIR MEDIANTE UN TABLE CALENDAR
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // LIBERAMOS LA MEMORIA DE LOS CONTROLADORES
  @override
  void dispose() {
    _nombreController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // PROVIDER Y LISTA DE ALUMNOS
    final alumnosProvider = Provider.of<ProviderScreen>(context);
    final List<Alumnos> alumnos = alumnosProvider.alumnos;
    alumnosProvider.getUserFromSheet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Añadir Expulsado'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => expulsadosScreen()),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa el nombre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cursoController,
                      decoration: InputDecoration(labelText: 'Curso'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa el curso';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Fecha:',
                      style: TextStyle(fontSize: 16),
                    ),
                    _selectedDay != null
                        ? Text(
                            // FORMATO
                            DateFormat('dd/MM/yyyy').format(_selectedDay!),
                            style: TextStyle(fontSize: 16),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    // CALENDARIO
                    TableCalendar(
                      // FORMATO DE CALENDARIO
                      calendarFormat: _calendarFormat,
                      // DIA QUE VIENE POR DEFECTO
                      focusedDay: _focusedDay,
                      // PONEMOS POR EJEMPLO 5 AÑOS DE LIMITE A LA FECHA FINAL
                      firstDay: DateTime(DateTime.now().year - 5),
                      lastDay: DateTime(DateTime.now().year + 5),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // INSERAMOS SI EL FORMULARIO VALIDA, LOS CONTROLADORES VAN ASOCIADOS A LOS FORMULARIOS
                        if (_formKey.currentState!.validate() &&
                            _selectedDay != null) {
                          final nombre = _nombreController.text;
                          final curso = _cursoController.text;
                          final observaciones =
                              DateFormat('dd/MM/yyyy').format(_selectedDay!);
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
                          // CREDENCIALES
                          final gsheets = GSheets(credenciales);
                          final ss = await gsheets.spreadsheet(spreadsheetID);
                          // TITULO DE LA HOJA A INSERTAR
                          var sheet = ss.worksheetByTitle('Expulsados');
                          // INSERTAMOS
                          await sheet?.values
                              .appendRow([nombre, curso, observaciones]);

                          // VUELVE HACIA ATRÁS UNA VEZ INSERTADO
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Insertar'),
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
