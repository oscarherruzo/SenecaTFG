import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seneca_tfg/Pantallas/pantallasExport.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// CREDENCIALES
final credenciales = {
  "type": "service_account",
  "project_id": "senecatfg",
  "private_key_id": "56a21047f511cba37f50da836a22e1a5bfc662e5",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDgKV/GB5FZJFYF\nsIyuOHVPypMCmhD+SwS9nh+KWF4u/ro2S8AhZXw38GIkxjTpZatBsOiSYoSCFcKI\nfndlsoAgCKMb3a9eF4hFypFkqTqoBwE4SYypyHxwZf6vaGUYTareG7FI3PRiDhwA\n9fx4XYZY/NpCSfCIxLpisaHIWiG8VpI4aE4voOfqcMtNWHeDwmn7pdqD9Opb0To9\nejN3uFIZk10OhdLnT4M85+dmU4m8kUFJQQ5eV38WZ6eXV0jk625sNTBWwhwJG+x+\neGRCvjPx2bQX7CcHfi+pEkVaCwKRGuGZTmsot1qxrcnLKEZmAevqUIfvGAMGnm73\n/6RbdN7DAgMBAAECggEAFMWgu2AOJv2H/yT6FFblAAzcjJwsQPRArzWM5KwFpkMy\njD9+wVl/JkvfPFslog8qzH6RPqdkcg2EJlPZypG877r9KmLjkkuJ9DWuPW61Icbs\nZQPjxgPvDBdXf3ekDpl74PMd/YuEFeYK0Ef7Kkg4X9ymeQgTAwl/4A9n14IKqEIN\nCqNTkYvbVVWH5DCb09qDhJCHBl/tBUaAsQtWn8Wl+hO9PCWPyXned5XZVKwi4hcO\n2xWygdB499+7FGLfBBsKiL8kOAjGnuX75Dc19ybgRpHUja9faSTDxd5G0N5ZM2l3\nHWUTRC3sBawgZJqfp/Rjk+6vUQrTdF6ZgksBteDkwQKBgQDxlYl9o7Bjnxa9zY/8\nZKXgHJNErM5vTyd3kPjULvBqyWVIdTQQ8184Cz7tGvVSNLOPkz8X3teyyRK/m4OF\n5lEpYSJc16fYrjGvDRwtktD8192JaN2KlBNzqXqbwH2+Dnr4qQy8Xu1VdRJ8L6HG\nhmmKi560/G09LGXdzbTAmxqMowKBgQDtibBlBIYKlpod826buqUEUymIxuGK5AwF\nt6zDLyPPNnpoZ8wXOnn4bUtbkDpHSWWEGDPj4vunsq6chgJos7wtMXJ5faCfLgmy\nEu5wAEdHpi8gH6cpZDEn4qw/MpAsXcEQECizKVgHMWMxlivQ05RacXEmTCdQ/m3F\nMADzpfBnYQKBgQDSDkv2SpXciT+k2VARDRKNw0rps7frYM/YTt2M4SN6NpMyZXZY\nJsTsXhrg30ffqqNWe5moj8LNWbhLklTR4GlBqYvPXlQ7O3tH0gZmOfotXyTpjZzU\nGdyv/PT26HBtCPozrAm+4GtMmvbvtBreG5E5Ph1JEROK1UfdjDdWIYb8MQKBgHlB\n03EN6RsYnB3z+Z+3nKtjhI1U8SfEmDqG88NDmiUaK0yGyBGHgWIG8PQR4R4o4pCX\nBk4rvclyll5CrpIiRkpPtp88OTVo+/wSW/OCwOBbfi0I231urwUsWj98oUp0pax8\ngzpKPayWUouqnD1i9JVi2Z7yOxPGfeSuR54ZNGqhAoGBAOSRhTmYwyz5CrEe0JPL\nC2DpFTcnhMCHBz2U0jaGAM8mwZBRnvD+xd47FvQHqEk6aTaT8fo3cI3dk1O08ZVt\nEBUxW5pPr/uqBzHJhCkAfXshkKW1JHNx1MQ5s1aCXqX40qTAJ/MChoOxt0CKU/6X\nFaNqL3GJt45U/by6aYnyJQ6h\n-----END PRIVATE KEY-----\n",
  "client_email": "oscartfg@senecatfg.iam.gserviceaccount.com",
  "client_id": "115965778508200535757",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/oscartfg%40senecatfg.iam.gserviceaccount.com"
};

final spreadsheetID = '1EQ8RroLG2qQEmuyURmh9jFpq0uJEm3OvQ3jUc6dkCmw';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderScreen>(
          create: (context) => ProviderScreen(),
        ),
        ChangeNotifierProvider<providerExpulsados>(
          create: (context) => providerExpulsados(),
        ),
        ChangeNotifierProvider<providerProfesores>(
          create: (context) => providerProfesores(),
        ),
        ChangeNotifierProvider<EmailProvider>(
          create: (context) => EmailProvider(),
        ),
        ChangeNotifierProvider<ConvivenciaProvider>(
          create: (context) => ConvivenciaProvider(),
        ),
        ChangeNotifierProvider<DACEProvider>(
          create: (context) => DACEProvider(),
        ),
        ChangeNotifierProvider<EntradaProvider>(
          create: (context) => EntradaProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/informes',
      routes: {
        '/': (context) => loginGSScreen(),
        '/menu': (context) => MenuScreen(),
        '/alumnos': (context) => AlumnosScreen(),
        '/profesores': (context) => ProfesoresScreen(),
        '/convivencia': (context) => ConvivenciaScreen(),
        '/dace': (context) => DACEScreen(),
        '/baño-previa': (context) => banioPreviaScreen(),
        '/alumno-añadir': (context) => anadirAlumno(),
        '/expulsado-añadir': (context) => ExpulsadosInsertScreen(),
        '/mayores': (context) => MayoresScreen(),
        '/baño': (context) => SalidaScreen(),
        '/informes': (context) => InformesScreen(),
      },
    );
  }
}
