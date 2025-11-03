import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF64B5F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Encabezado del Drawer
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/hombre.jpg'),
              ),
              accountName: const Text(
                'Kevin Nivesela',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('ksa.nivesela@yavirac.edu.ec'),
            ),

            // Opción: Inicio
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/inicio', (route) => false);
              },
            ),

            // Opción: Perfil
            _buildDrawerItem(
              icon: Icons.person,
              text: 'Perfil',
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),

            // Opción: Notificaciones
            _buildDrawerItem(
              icon: Icons.notifications_active,
              text: 'Notificaciones',
              onTap: () {
                Navigator.pushNamed(context, '/notificacion');
              },
            ),

            // Opción: Configuración
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Configuración',
              onTap: () {
                Navigator.pushNamed(context, '/configuracion');
              },
            ),

            //Acerca de
            _buildDrawerItem(
              icon: Icons.help_outline,
              text: 'Acerca de',
              onTap: () {
                Navigator.pushNamed(context, '/acerca');
              },
            ),

            // Opción: Siguiente (pantalla final)
            _buildDrawerItem(
              icon: Icons.arrow_forward_ios,
              text: 'Siguiente',
              onTap: () {
                Navigator.pushNamed(context, '/siguiente');
              },
            ),

            const Divider(
              color: Colors.white70,
              indent: 20,
              endIndent: 20,
            ),

            // Opción final: Salir o Cerrar sesión
            _buildDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar sesión',
              color: Colors.redAccent,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/inicio', (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sesión cerrada'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Método reutilizable para crear cada opción del Drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color, fontSize: 16),
      ),
      hoverColor: Colors.white24,
      onTap: onTap,
    );
  }
}
