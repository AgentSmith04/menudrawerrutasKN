import 'package:flutter/material.dart';
import 'clientes_page.dart';
import 'barberos_page.dart';
import 'citas_page.dart';
import 'configuracion_page.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color azulMarino = const Color(0xFF0D1B2A);
    final Color beigeClaro = const Color(0xFFF5F5DC);
    final Color beigeOscuro = const Color(0xFFD2B48C);
    final Color gris = const Color(0xFF778DA9);
    final Color blancoHueso = const Color(0xFFFAF9F6);

    return Scaffold(
      backgroundColor: blancoHueso,
      appBar: AppBar(
        backgroundColor: azulMarino,
        title: const Text('Gestor de Barbería 💈'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cut, size: 80, color: beigeOscuro),
              const SizedBox(height: 15),
              Text(
                'Bienvenido al Gestor de Barbería',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: azulMarino,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Administra tus citas, clientes y barberos de manera profesional y sencilla.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              const SizedBox(height: 35),

              // MENÚ PRINCIPAL CENTRADO
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _menuCard(context, Icons.people, 'Clientes',
                      const ClientesPage(), beigeOscuro, azulMarino),
                  _menuCard(context, Icons.cut, 'Barberos',
                      const BarberosPage(), gris, azulMarino),
                  _menuCard(context, Icons.calendar_month, 'Citas',
                      const CitasPage(), azulMarino, azulMarino),
                  _menuCard(context, Icons.settings, 'Configuración',
                      const ConfiguracionPage(), Colors.grey.shade600,
                      azulMarino),
                ],
              ),

              const SizedBox(height: 45),

              // BOTÓN "ACERCA DEL SISTEMA"
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: azulMarino,
                    content: const Text(
                      'Desarrollado por Kevin Nivesela 💈 BarberApp',
                      textAlign: TextAlign.center,
                    ),
                  ));
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('Acerca del sistema'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: azulMarino,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, IconData icon, String text,
      Widget route, Color color, Color azulMarino) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => route)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: azulMarino,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
