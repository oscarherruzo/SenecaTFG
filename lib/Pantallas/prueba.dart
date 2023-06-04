import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Providers/entradaClass.dart';
import '../Providers/entradaProvider.dart';

// Clase para almacenar la información del alumno
class Alumno {
  final String nombre;
  final String fecha;

  final int vecesSalida;

  Alumno({
    required this.vecesSalida,
    required this.nombre,
    required this.fecha,
  });
}

class PruebaScreen extends StatefulWidget {
  @override
  _PruebaScreenState createState() => _PruebaScreenState();
}

class _PruebaScreenState extends State<PruebaScreen> {
  DateTime? fechaInicio;
  DateTime? fechaFin;
  List<Alumno> alumnosFiltrados = [];

  int calcularVecesSalida(List<Entrada> alumnos, String nombreAlumno) {
    int contador = 0;
    for (var alumno in alumnos) {
      if (alumno.nombre == nombreAlumno) {
        contador++;
      }
    }
    return contador;
  }

  @override
  Widget build(BuildContext context) {
    final alumnosProvider = Provider.of<EntradaProvider>(context);
    final List<Entrada> alumnos = alumnosProvider.entradasLista;
    alumnosProvider.getUserFromSheet();

    // Crear la lista de alumnos
    List<Alumno> listaAlumnos = alumnos.map((entrada) {
      // Obtener la fecha en formato dd/mm/yyyy
      String fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());
      int vecesSalida = calcularVecesSalida(alumnos, entrada.nombre);
      return Alumno(
        nombre: entrada.nombre,
        fecha: fecha,
        vecesSalida: vecesSalida,
      );
    }).toList();

    // Filtrar los alumnos por fecha
    alumnosFiltrados = listaAlumnos.where((alumno) {
      if (fechaInicio != null && fechaFin != null) {
        DateTime alumnoDate = DateFormat('dd/MM/yyyy').parse(alumno.fecha);
        return alumnoDate.isAfter(fechaInicio!) &&
            alumnoDate.isBefore(fechaFin!);
      }
      return true;
    }).toList();

    // Ordenar los alumnos de mayor a menor cantidad de salidas
    alumnosFiltrados.sort((a, b) => b.vecesSalida.compareTo(a.vecesSalida));

    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Fecha inicio:',
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  ).then((date) {
                    setState(() {
                      fechaInicio = date;
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    fechaInicio != null
                        ? DateFormat('dd/MM/yyyy').format(fechaInicio!)
                        : 'Seleccionar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Fecha fin:',
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  ).then((date) {
                    setState(() {
                      fechaFin = date;
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    fechaFin != null
                        ? DateFormat('dd/MM/yyyy').format(fechaFin!)
                        : 'Seleccionar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Filtrar y ordenar los alumnos nuevamente
              alumnosFiltrados = listaAlumnos.where((alumno) {
                if (fechaInicio != null && fechaFin != null) {
                  DateTime alumnoDate =
                      DateFormat('dd/MM/yyyy').parse(alumno.fecha);
                  return alumnoDate.isAfter(fechaInicio!) &&
                      alumnoDate.isBefore(fechaFin!);
                }
                return true;
              }).toList();
              alumnosFiltrados
                  .sort((a, b) => b.vecesSalida.compareTo(a.vecesSalida));

              setState(() {});
            },
            child: Text('Filtrar Alumnos'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: alumnosFiltrados.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(alumnosFiltrados[index].nombre),
                  subtitle: Text('Fecha: ${alumnosFiltrados[index].fecha}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
