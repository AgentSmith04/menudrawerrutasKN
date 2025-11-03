import 'package:flutter/material.dart';
import 'package:menudrawer/src/navbar.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color(0xFF2196F3),
        elevation: 4,
      ),
      drawer: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Banner superior con gradiente
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF673AB7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.flutter_dash, color: Colors.white, size: 90),
                  SizedBox(height: 10),
                  Text(
                    'Bienvenido, Kevin 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Explora todas las secciones desde el menú lateral y descubre funcionalidades adicionales de la app.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // 🔹 Sección de accesos rápidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    'Accesos Rápidos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F51B5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildCard(
                        context,
                        icon: Icons.person,
                        title: 'Perfil',
                        description: 'Revisa tu información personal, contacto y actualiza tus datos.',
                        color: Colors.blueAccent,
                        route: '/perfil',
                      ),
                      _buildCard(
                        context,
                        icon: Icons.notifications,
                        title: 'Notificaciones',
                        description: 'Consulta las alertas y mensajes recientes de la app.',
                        color: Colors.orangeAccent,
                        route: '/notificacion',
                      ),
                      _buildCard(
                        context,
                        icon: Icons.settings,
                        title: 'Configuración',
                        description: 'Ajusta tus preferencias, modo oscuro, sonidos y notificaciones.',
                        color: Colors.deepPurple,
                        route: '/configuracion',
                      ),
                      _buildCard(
                        context,
                        icon: Icons.help_outline,
                        title: 'Acerca de',
                        description: 'Conoce información sobre la app y el desarrollador.',
                        color: Colors.pinkAccent,
                        route: '/acerca',
                      ),
                      _buildCard(
                        context,
                        icon: Icons.arrow_forward,
                        title: 'Siguiente',
                        description: 'Explora la pantalla final y los mensajes de cierre de la app.',
                        color: Colors.indigo,
                        route: '/siguiente',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // 🔹 Botones principales de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  label: const Text('Abrir Menú'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/perfil');
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Ir a Perfil'),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // 🔹 Pie de página
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: const Text(
                '© 2025 App creada por Kevin Nivesela',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjeta de acceso rápido con animación
  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 28,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
