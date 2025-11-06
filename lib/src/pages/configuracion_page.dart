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
      backgroundColor: const Color(0xFFF5F5DC),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Text(
            'Configuración del sistema',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF001F3F)),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text('Activa o desactiva las alertas del sistema'),
            activeColor: Color(0xFF001F3F),
            value: notificaciones,
            onChanged: (value) => setState(() => notificaciones = value),
          ),
          SwitchListTile(
            title: const Text('Modo oscuro'),
            subtitle: const Text('Cambia el tema visual de la app'),
            activeColor: Color(0xFF001F3F),
            value: modoOscuro,
            onChanged: (value) => setState(() => modoOscuro = value),
          ),
          SwitchListTile(
            title: const Text('Sonidos'),
            subtitle: const Text('Reproduce sonidos al realizar acciones'),
            activeColor: Color(0xFF001F3F),
            value: sonidos,
            onChanged: (value) => setState(() => sonidos = value),
          ),
          const Divider(),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuraciones guardadas correctamente.')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('Guardar cambios'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD2B48C),
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
