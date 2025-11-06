import 'package:flutter/material.dart';

class BarberosPage extends StatefulWidget {
  const BarberosPage({super.key});

  @override
  State<BarberosPage> createState() => _BarberosPageState();
}

class _BarberosPageState extends State<BarberosPage> {
  final List<Map<String, String>> barberos = [
    {
      'nombre': 'Mario Cortez',
      'telefono': '+593 987111222',
      'correo': 'mario.cortez@barberia.com',
      'especialidad': 'Cortes clásicos y degradados',
      'experiencia': '5 años',
      'foto': 'https://randomuser.me/api/portraits/men/21.jpg'
    },
    {
      'nombre': 'David Salas',
      'telefono': '+593 999222333',
      'correo': 'david.salas@barberia.com',
      'especialidad': 'Afeitado con navaja y barbería moderna',
      'experiencia': '3 años',
      'foto': 'https://randomuser.me/api/portraits/men/33.jpg'
    },
    {
      'nombre': 'Esteban Ruiz',
      'telefono': '+593 988333444',
      'correo': 'esteban.ruiz@barberia.com',
      'especialidad': 'Cortes urbanos y diseño de barba',
      'experiencia': '4 años',
      'foto': 'https://randomuser.me/api/portraits/men/40.jpg'
    },
  ];

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _especialidadController = TextEditingController();
  final _experienciaController = TextEditingController();

  void _mostrarFormulario({int? index}) {
    if (index != null) {
      final b = barberos[index];
      _nombreController.text = b['nombre'] ?? '';
      _telefonoController.text = b['telefono'] ?? '';
      _correoController.text = b['correo'] ?? '';
      _especialidadController.text = b['especialidad'] ?? '';
      _experienciaController.text = b['experiencia'] ?? '';
    } else {
      _nombreController.clear();
      _telefonoController.clear();
      _correoController.clear();
      _especialidadController.clear();
      _experienciaController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F3E7), // Beige claro
        title: Text(
          index == null ? "Agregar Nuevo Barbero 💈" : "Editar Barbero",
          style: const TextStyle(color: Color(0xFF1A237E)), // Azul marino
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _inputField("Nombre", _nombreController),
              _inputField("Teléfono", _telefonoController, TextInputType.phone),
              _inputField("Correo", _correoController),
              _inputField("Especialidad", _especialidadController),
              _inputField("Años de experiencia", _experienciaController, TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (index == null) {
                _limpiarCampos();
              }
            },
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E), // Azul marino
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final nombre = _nombreController.text.trim();
              final telefono = _telefonoController.text.trim();
              final correo = _correoController.text.trim();
              final especialidad = _especialidadController.text.trim();
              final experiencia = _experienciaController.text.trim();

              if (nombre.isEmpty || telefono.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nombre y teléfono son requeridos')),
                );
                return;
              }

              setState(() {
                if (index == null) {
                  barberos.add({
                    'nombre': nombre,
                    'telefono': telefono,
                    'correo': correo,
                    'especialidad': especialidad.isEmpty ? 'General' : especialidad,
                    'experiencia': experiencia.isEmpty ? '0 años' : '$experiencia años',
                    'foto': 'https://randomuser.me/api/portraits/men/${(barberos.length + 20) % 99}.jpg',
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$nombre agregado')));
                } else {
                  barberos[index] = {
                    'nombre': nombre,
                    'telefono': telefono,
                    'correo': correo,
                    'especialidad': especialidad.isEmpty ? barberos[index]['especialidad'] ?? 'General' : especialidad,
                    'experiencia': experiencia.isEmpty ? barberos[index]['experiencia'] ?? '0 años' : '$experiencia años',
                    'foto': barberos[index]['foto'] ?? 'https://randomuser.me/api/portraits/men/20.jpg',
                  };
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$nombre actualizado')));
                }
              });

              Navigator.pop(context);
              _limpiarCampos();
            },
            child: Text(index == null ? 'Guardar' : 'Actualizar'),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF3E2723)), // Beige oscuro
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1A237E), width: 1.5), // Azul marino
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBCAAA4), width: 1), // Beige medio
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  void _limpiarCampos() {
    _nombreController.clear();
    _telefonoController.clear();
    _correoController.clear();
    _especialidadController.clear();
    _experienciaController.clear();
  }

  void _eliminarBarbero(int index) {
    final nombre = barberos[index]['nombre'] ?? 'barbero';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F3E7),
        title: const Text('Eliminar barbero', style: TextStyle(color: Color(0xFF1A237E))),
        content: Text('¿Deseas eliminar a $nombre?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              setState(() => barberos.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$nombre eliminado')));
            },
            child: const Text('Eliminar'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _especialidadController.dispose();
    _experienciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF6), // Blanco hueso
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E), // Azul marino
        title: const Text(
          'Equipo de Barberos 💈',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lista actualizada')));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3E2723), // Beige oscuro (oscuro cálido)
        onPressed: () => _mostrarFormulario(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: barberos.isEmpty
          ? const Center(
              child: Text(
                'No hay barberos registrados.\nPresiona + para agregar uno.',
                style: TextStyle(color: Color(0xFF3E2723)),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: barberos.length,
              itemBuilder: (context, index) {
                final b = barberos[index];
                return Card(
                  color: const Color(0xFFFAF3E0), // Beige claro
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(b['foto'] ?? ''),
                    ),
                    title: Text(
                      b['nombre'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    subtitle: Text(
                      '✂️ ${b['especialidad']}\n⭐ ${b['experiencia']}\n📞 ${b['telefono']}',
                      style: const TextStyle(color: Color(0xFF3E2723)),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color(0xFF546E7A)), // Gris azulado
                            onPressed: () => _mostrarFormulario(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _eliminarBarbero(index),
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
