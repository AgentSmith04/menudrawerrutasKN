import 'package:flutter/material.dart';
import 'package:menudrawer/src/navbar.dart';

class SiguientePage extends StatelessWidget {
  const SiguientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Pantalla Final'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 90, color: Color(0xFF2196F3)),
              const SizedBox(height: 20),
              const Text(
                '¡Has llegado al final!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Gracias por usar nuestra aplicación. Esperamos que la experiencia haya sido '
                'intuitiva, visualmente atractiva y funcional.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // ✅ Sección de resumen de funciones
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      Text(
                        'Resumen de Funciones',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '• Acceso rápido a Perfil, Notificaciones, Configuración y más.\n'
                        '• Navegación sencilla con Drawer personalizado.\n'
                        '• Experiencia visual con gradientes y colores modernos.\n'
                        '• Funcionalidad responsiva en diferentes dispositivos.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Consejos y recomendaciones
              Card(
                color: Colors.blue.shade50,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      Text(
                        'Consejos de uso',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '• Mantén tu perfil actualizado para una mejor experiencia.\n'
                        '• Revisa las notificaciones regularmente para no perder eventos importantes.\n'
                        '• Personaliza tu configuración según tus preferencias.\n'
                        '• Explora todas las secciones y aprende a sacarle el máximo provecho.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Botones de acción
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
                },
                icon: const Icon(Icons.home),
                label: const Text('Volver al Inicio'),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Por ejemplo: mostrar tutorial o ayuda adicional
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Tips Adicionales'),
                      content: const Text(
                          'Puedes explorar más funciones en futuras versiones y personalizar tu experiencia.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.lightbulb),
                label: const Text('Tips de Uso'),
              ),

              const SizedBox(height: 40),
              const Text(
                '© 2025 App creada por Kevin Nivesela',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
