import 'package:flutter/material.dart';

class AcercaPage extends StatelessWidget {
  const AcercaPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color azulMarino = Color(0xFF001F3F);
    const Color beigeClaro = Color(0xFFF5F5DC);
    const Color beigeOscuro = Color(0xFFD2B48C);
    const Color gris = Color(0xFFB0B0B0);
    const Color blancoHueso = Color(0xFFFAF9F6);

    return Scaffold(
      backgroundColor: blancoHueso,
      appBar: AppBar(
        title: const Text('Acerca de la Aplicación'),
        backgroundColor: azulMarino,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Encabezado con gradiente cálido
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [azulMarino, beigeOscuro],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.cut, size: 80, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    'Barbería Nivesela',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Versión 1.0.0',
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aplicación creada para la gestión de turnos y clientes en barberías, '
                    'ofreciendo un diseño moderno, profesional y funcional.',
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Descripción de la app
            Card(
              color: beigeClaro,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: azulMarino,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Esta aplicación permite gestionar barberos, clientes y citas de manera ágil y sencilla. '
                      'Su interfaz combina colores sobrios y elegantes inspirados en el estilo clásico de barbería.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Información del desarrollador
            Card(
              color: beigeOscuro,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/hombre.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Desarrollado por:',
                      style: TextStyle(
                        color: azulMarino,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Kevin Nivesela',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      'Estudiante de Desarrollo de Software en Yavirac',
                      style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Iconos de contacto o redes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.email, color: azulMarino),
                  iconSize: 32,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.web, color: azulMarino),
                  iconSize: 32,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.phone_android, color: azulMarino),
                  iconSize: 32,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Botón para volver al inicio
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: azulMarino,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/inicio', (route) => false);
              },
              icon: const Icon(Icons.home),
              label: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
