//Kevin Nivesela
import 'package:flutter/material.dart';
import 'package:menudrawer/src/inicio.dart';
import 'package:menudrawer/src/notificacion.dart';
import 'package:menudrawer/src/perfil.dart';
import 'package:menudrawer/src/siguiente.dart';
import 'package:menudrawer/src/navbar.dart';
import 'package:menudrawer/src/configuracion.dart';
import 'package:menudrawer/src/acerca.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menú Drawer con Rutas',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/inicio', // ✅ Ruta inicial
      routes: {
        '/inicio': (context) => const InicioPage(),
        '/perfil': (context) => const PerfilPage(),
        '/notificacion': (context) => const NotificacionPage(),
        '/siguiente': (context) => const SiguientePage(),
        '/navbar': (context) => const Navbar(),
        '/configuracion': (context) => const ConfiguracionPage(),
        '/acerca': (context) => const AcercaPage(),
      },
    );
  }
}
