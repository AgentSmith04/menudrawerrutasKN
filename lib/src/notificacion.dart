import 'package:flutter/material.dart';
import 'package:menudrawer/src/navbar.dart';

class NotificacionPage extends StatelessWidget {
  const NotificacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Notificaciones'),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Últimas notificaciones',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildNotificacionCard(
                    Icons.email,
                    'Nuevo mensaje',
                    'Has recibido un correo de confirmación. ¡Revísalo pronto!',
                  ),
                  _buildNotificacionCard(
                    Icons.update,
                    'Actualización disponible',
                    'La app tiene nuevas funciones y mejoras de rendimiento.',
                  ),
                  _buildNotificacionCard(
                    Icons.calendar_today,
                    'Cita programada',
                    'Tienes una cita para el lunes a las 9:00 am.',
                  ),
                  _buildNotificacionCard(
                    Icons.info,
                    'Recordatorio',
                    'No olvides actualizar tus datos en Perfil para una mejor experiencia.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Atrás'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/siguiente');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Siguiente'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNotificacionCard(IconData icon, String title, String message) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2196F3),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
      ),
    );
  }
}
