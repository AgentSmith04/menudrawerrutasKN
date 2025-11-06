import 'package:flutter/material.dart';
import 'pages/inicio_page.dart';
import 'pages/clientes_page.dart';
import 'pages/citas_page.dart';
import 'pages/barberos_page.dart';
import 'pages/configuracion_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int index = 0;

  final List<Widget> pages = const [
    InicioPage(),
    ClientesPage(),
    CitasPage(),
    BarberosPage(),
    ConfiguracionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Barbería 💈'),
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      body: pages[index],
      drawer: Drawer(
        backgroundColor: const Color(0xFFF8F9FA),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.cut, size: 64, color: Colors.white),
                  SizedBox(height: 10),
                  Text('Gestor de Barbería',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('Controla citas, clientes y barberos',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            _buildItem(Icons.home, 'Inicio', 0),
            _buildItem(Icons.person, 'Clientes', 1),
            _buildItem(Icons.calendar_month, 'Citas', 2),
            _buildItem(Icons.people_alt, 'Barberos', 3),
            _buildItem(Icons.settings, 'Configuración', 4),
          ],
        ),
      ),
    );
  }

  ListTile _buildItem(IconData icon, String title, int i) {
    return ListTile(
      leading: Icon(icon,
          color: index == i ? const Color(0xFFB08968) : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
            color: index == i
                ? const Color(0xFF0D1B2A)
                : Colors.black.withOpacity(0.8),
            fontWeight: index == i ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () {
        setState(() => index = i);
        Navigator.pop(context);
      },
    );
  }
}
