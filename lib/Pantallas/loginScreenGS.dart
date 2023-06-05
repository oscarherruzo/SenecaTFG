import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';

// CLASE LOGIN GS SCREEN
class loginGSScreen extends StatefulWidget {
  @override
  _loginGSScreenState createState() => _loginGSScreenState();
}

class _loginGSScreenState extends State<loginGSScreen> {
  // INICIALIZAMOS VARIALES
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    // PROVIDERS DE LA LISTA QUE TIENE LOS CORREOS Y CONTRASEÑAS
    final alumnosProvider = Provider.of<EmailProvider>(context);
    final List<googleClass> alumnos = alumnosProvider.profesores;
    alumnosProvider.getUserFromSheet();
// EL USUARIO NO PUEDE ACCEDER A OTRA PANTALLA
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
                    // IMAGEN DE ISENECA
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
                  // BORDES GRISES
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
                          style: TextStyle(color: Colors.white),
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
                          // TEXTO DE LA CONTRASEÑA QUE NO SE MUESTRE
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isLoggingIn
                            // SI ES VERDADERO A NULO
                            ? null
                            // SI NO ESTA LOGUEADO PASAMOS VACIAMOS EL MENSAJE Y DEFINIMOS isLoggingIn A TRUE
                            : () async {
                                setState(() {
                                  errorMessage = '';
                                  isLoggingIn = true;
                                });
                                // VARIABLES EN LAS QUE GUARDAMOS LOS TEXTOS RECOLECTADOS DE LOS TEXTFORMFIELD
                                String email = emailController.text;
                                String password = passwordController.text;
                                // BOOLEANA PARA COMPROBAR SI ESTÁ TODO CORRECTO O NO
                                bool esValida = false;
                                // BUCLE PARA COMPROBAR SI ALGUNO DE LOS MAILS Y CONTRASEÑAS SON CORRECTOS
                                for (var alumno in alumnos) {
                                  if (alumno.mail == email &&
                                      alumno.contrasenia == password) {
                                    esValida = true;
                                    break;
                                  }
                                }
                                // SI ES VÁLIDA ESTABLECEMOS EL MENSAJE DE ERROR POR DEFECTO A VACÍO
                                if (esValida) {
                                  setState(() {
                                    errorMessage = '';
                                  });
                                  // NAVEGAMOS AL MENÚ
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuScreen(),
                                    ),
                                  );
                                  // SI NO MOSTRAMOS EL MENSAJE DE ARROR
                                } else {
                                  setState(() {
                                    errorMessage =
                                        'Email o contraseña incorrectos';
                                    //BOOLEANA DEFINIDA A FALSO
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
                      // SI EL MENSAJE NO ESTA VACIO
                      if (errorMessage.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          // MOSTRAMOS EL MENSAJE
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              // DEFINIMOS EL COLOR DEL TEXTO A ROJO
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // POSICION DEL LOGO
              Positioned.fromRect(
                rect: Rect.fromLTWH(
                  MediaQuery.of(context).size.width * 0.25,
                  MediaQuery.of(context).size.height * 0.15,
                  MediaQuery.of(context).size.width * 0.5,
                  MediaQuery.of(context).size.height * 0.3,
                ),
                child: IgnorePointer(
                  ignoring: true,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // POSICION DEL ICONO DE LA JUNTA
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
