import 'package:flutter/material.dart';

// 🔹 Simulación de listas globales (sincronizadas con otras páginas)
List<Map<String, String>> clientesGlobal = [
  {'nombre': 'Juan Pérez', 'telefono': '0991234567'},
  {'nombre': 'Carlos Gómez', 'telefono': '0987654321'},
  {'nombre': 'Andrés Silva', 'telefono': '0971122334'},
];

List<Map<String, String>> barberosGlobal = [
  {'nombre': 'Mario Cortez', 'especialidad': 'Cortes modernos'},
  {'nombre': 'David Salas', 'especialidad': 'Barba y degradados'},
  {'nombre': 'Luis Torres', 'especialidad': 'Corte clásico'},
];

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  // Lista de citas con algunos datos iniciales
  final List<Map<String, String>> citas = [
    {
      'cliente': 'Juan Pérez',
      'barbero': 'Mario Cortez',
      'fecha': '2025-11-06',
      'hora': '10:30 AM',
      'servicio': 'Corte clásico + barba',
      'foto': 'https://randomuser.me/api/portraits/men/12.jpg',
    },
    {
      'cliente': 'Carlos Gómez',
      'barbero': 'David Salas',
      'fecha': '2025-11-06',
      'hora': '3:00 PM',
      'servicio': 'Afeitado completo',
      'foto': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
  ];

  // Controladores del formulario
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  final _servicioController = TextEditingController();

  String? _clienteSeleccionado;
  String? _barberoSeleccionado;

  void _mostrarFormulario({int? index}) {
    if (index != null) {
      final c = citas[index];
      _clienteSeleccionado = c['cliente'];
      _barberoSeleccionado = c['barbero'];
      _fechaController.text = c['fecha'] ?? '';
      _horaController.text = c['hora'] ?? '';
      _servicioController.text = c['servicio'] ?? '';
    } else {
      _clienteSeleccionado = null;
      _barberoSeleccionado = null;
      _fechaController.clear();
      _horaController.clear();
      _servicioController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC), // Beige claro
        title: Text(
          index == null ? "Agendar Nueva Cita 💈" : "Editar Cita",
          style: const TextStyle(color: Color(0xFF0D1B2A)), // Azul marino
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Seleccionar Cliente", style: TextStyle(color: Color(0xFF2F3E46))),
              DropdownButtonFormField<String>(
                value: _clienteSeleccionado,
                dropdownColor: const Color(0xFFF5F5DC),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEDE7D9),
                  border: OutlineInputBorder(),
                ),
                items: clientesGlobal.map((cliente) {
                  return DropdownMenuItem<String>(
                    value: cliente['nombre'],
                    child: Text(cliente['nombre']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _clienteSeleccionado = value);
                },
              ),
              const SizedBox(height: 10),
              const Text("Seleccionar Barbero", style: TextStyle(color: Color(0xFF2F3E46))),
              DropdownButtonFormField<String>(
                value: _barberoSeleccionado,
                dropdownColor: const Color(0xFFF5F5DC),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEDE7D9),
                  border: OutlineInputBorder(),
                ),
                items: barberosGlobal.map((barbero) {
                  return DropdownMenuItem<String>(
                    value: barbero['nombre'],
                    child: Text(barbero['nombre']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _barberoSeleccionado = value);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha (AAAA-MM-DD)',
                  filled: true,
                  fillColor: Color(0xFFEDE7D9),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _horaController,
                decoration: const InputDecoration(
                  labelText: 'Hora (Ej: 3:00 PM)',
                  filled: true,
                  fillColor: Color(0xFFEDE7D9),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _servicioController,
                decoration: const InputDecoration(
                  labelText: 'Servicio (Ej: Corte, Barba, Tinte)',
                  filled: true,
                  fillColor: Color(0xFFEDE7D9),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: Color(0xFF6C757D))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D1B2A), // Azul marino
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_clienteSeleccionado == null ||
                  _barberoSeleccionado == null ||
                  _fechaController.text.isEmpty ||
                  _horaController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor completa todos los campos')),
                );
                return;
              }

              setState(() {
                final nuevaCita = {
                  'cliente': _clienteSeleccionado!,
                  'barbero': _barberoSeleccionado!,
                  'fecha': _fechaController.text.trim(),
                  'hora': _horaController.text.trim(),
                  'servicio': _servicioController.text.trim(),
                  'foto': 'https://randomuser.me/api/portraits/men/${(citas.length + 60) % 99}.jpg',
                };

                if (index == null) {
                  citas.add(nuevaCita);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cita de $_clienteSeleccionado agendada exitosamente')),
                  );
                } else {
                  citas[index] = nuevaCita;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cita de $_clienteSeleccionado actualizada')),
                  );
                }
              });

              Navigator.pop(context);
            },
            child: Text(index == null ? "Guardar" : "Actualizar"),
          ),
        ],
      ),
    );
  }

  void _eliminarCita(int index) {
    final nombre = citas[index]['cliente'] ?? 'cliente';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC),
        title: const Text('Eliminar cita', style: TextStyle(color: Color(0xFF0D1B2A))),
        content: Text('¿Deseas eliminar la cita de $nombre?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              setState(() => citas.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cita de $nombre eliminada')));
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fechaController.dispose();
    _horaController.dispose();
    _servicioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6), // Blanco hueso
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        title: const Text("Citas Agendadas 💇‍♂️"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lista actualizada')));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1B263B),
        onPressed: () => _mostrarFormulario(),
        child: const Icon(Icons.add),
      ),
      body: citas.isEmpty
          ? const Center(
              child: Text(
                "No hay citas registradas.\nPresiona el botón + para agendar una.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];
                return Card(
                  color: const Color(0xFFEDE7D9), // beige grisáceo
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(cita['foto'] ?? ''),
                    ),
                    title: Text(
                      "${cita['cliente']} con ${cita['barbero']}",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D1B2A)),
                    ),
                    subtitle: Text(
                      "📅 ${cita['fecha']}  ⏰ ${cita['hora']}\n💈 ${cita['servicio']}",
                      style: const TextStyle(color: Color(0xFF2F3E46)),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color(0xFF1B263B)),
                            onPressed: () => _mostrarFormulario(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _eliminarCita(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
