import 'package:flutter/material.dart';
import 'src/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Barbería',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0D1B2A), // Azul marino
          onPrimary: Colors.white,
          secondary: Color(0xFFB08968), // Beige oscuro
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Color(0xFFF8F9FA),
          onBackground: Color(0xFF0D1B2A),
          surface: Color(0xFFDDBEA9), // Beige claro
          onSurface: Colors.black87,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1B2A),
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        useMaterial3: true,
      ),
      home: const Navbar(),
    );
  }
}
