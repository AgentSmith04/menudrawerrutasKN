import 'package:flutter/material.dart';
import 'package:menudrawer/src/navbar.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Perfil de Usuario'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/hombre.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kevin Nivesela',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ksa.nivesela@yavirac.edu.ec',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 25),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.phone, color: Color(0xFF2196F3)),
                    title: Text('Teléfono'),
                    subtitle: Text('+593 999 999 999'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Color(0xFF2196F3)),
                    title: Text('Ubicación'),
                    subtitle: Text('Quito, Ecuador'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.work, color: Color(0xFF2196F3)),
                    title: Text('Ocupación'),
                    subtitle: Text('Estudiante de Desarrollo de Software'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.school, color: Color(0xFF2196F3)),
                    title: Text('Nivel académico'),
                    subtitle: Text('Universitario'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/ajustes');
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('Ajustes'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar Perfil'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notificacion');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir a Notificaciones'),
            ),
          ],
        ),
      ),
    );
  }
}
