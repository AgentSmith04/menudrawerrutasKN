import 'package:flutter/material.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  bool notificaciones = true;
  bool modoOscuro = false;
  bool sonidos = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Configuración'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Título de preferencias
            const Text(
              'Preferencias de Usuario',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),

            // 🔹 Switches
            SwitchListTile(
              activeColor: const Color(0xFF2196F3),
              title: const Text('Notificaciones'),
              subtitle: const Text('Activar o desactivar notificaciones de la app'),
              value: notificaciones,
              onChanged: (value) {
                setState(() {
                  notificaciones = value;
                });
              },
            ),
            SwitchListTile(
              activeColor: const Color(0xFF2196F3),
              title: const Text('Modo oscuro'),
              subtitle: const Text('Cambia el tema de la aplicación entre claro y oscuro'),
              value: modoOscuro,
              onChanged: (value) {
                setState(() {
                  modoOscuro = value;
                });
              },
            ),
            SwitchListTile(
              activeColor: const Color(0xFF2196F3),
              title: const Text('Sonidos'),
              subtitle: const Text('Reproducir sonidos de la app al interactuar'),
              value: sonidos,
              onChanged: (value) {
                setState(() {
                  sonidos = value;
                });
              },
            ),
            const Divider(),
            const SizedBox(height: 20),

            // 🔹 Botón guardar
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Guardar Cambios'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cambios guardados correctamente'),
                      backgroundColor: Color(0xFF1565C0),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // 🔹 Sección de información adicional
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Información de la App',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Versión: 1.0.0', style: TextStyle(fontSize: 16)),
                    Text('Desarrollador: Kevin Nivesela', style: TextStyle(fontSize: 16)),
                    Text('Contacto: ksa.nivesela@yavirac.edu.ec', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Botón volver al inicio
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
                },
                child: const Text('Volver al Inicio'),
              ),
            ),
            const SizedBox(height: 40),

            // 🔹 Pie de página
            const Center(
              child: Text(
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
}
