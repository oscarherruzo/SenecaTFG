import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/menuScreen.dart';
import 'package:seneca_tfg/Providers/Alumnos.dart';
import 'package:seneca_tfg/Providers/Provider.dart';
import 'package:seneca_tfg/Providers/googleClass.dart';
import 'package:seneca_tfg/Providers/googleProvider.dart';

class loginGSScreen extends StatefulWidget {
  @override
  _loginGSScreenState createState() => _loginGSScreenState();
}

class _loginGSScreenState extends State<loginGSScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    final alumnosProvider = Provider.of<EmailProvider>(context);
    final List<googleClass> alumnos = alumnosProvider.profesores;
    alumnosProvider.getUserFromSheet();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: const Text('Inicio de sesión'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.blue.shade900,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Image.asset(
                        'assets/iseneca.png',
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
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
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(
                              color: Colors
                                  .white), // Cambio de color del texto a blanco
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: passwordController,
                          style: TextStyle(
                              color: Colors
                                  .white), // Cambio de color del texto a blanco
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isLoggingIn
                            ? null
                            : () async {
                                setState(() {
                                  errorMessage = '';
                                  isLoggingIn = true;
                                });

                                String email = emailController.text;
                                String password = passwordController.text;
                                bool isValid = false;

                                for (var alumno in alumnos) {
                                  if (alumno.mail == email &&
                                      alumno.contrasenia == password) {
                                    isValid = true;
                                    break;
                                  }
                                }

                                if (isValid) {
                                  setState(() {
                                    errorMessage = '';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuScreen(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    errorMessage =
                                        'Email o contraseña incorrectos';
                                    isLoggingIn = false;
                                  });
                                }
                              },
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              color: Colors
                                  .white), // Cambio de color del texto a blanco
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.white)),
                        ),
                      ),
                      if (errorMessage.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(
                  '3.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
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
        ),
      ),
    );
  }
}
