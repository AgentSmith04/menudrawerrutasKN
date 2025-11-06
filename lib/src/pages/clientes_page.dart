import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  // Datos precargados (no eliminan la posibilidad de agregar nuevos)
  final List<Map<String, String>> clientes = [
    {
      'nombre': 'Juan Pérez',
      'telefono': '+593 987654321',
      'correo': 'juanperez@mail.com',
      'servicio': 'Corte clásico',
      'foto': 'https://randomuser.me/api/portraits/men/12.jpg'
    },
    {
      'nombre': 'Carlos Gómez',
      'telefono': '+593 998877665',
      'correo': 'cgomez@mail.com',
      'servicio': 'Afeitado + arreglo de barba',
      'foto': 'https://randomuser.me/api/portraits/men/32.jpg'
    },
    {
      'nombre': 'Luis Fernández',
      'telefono': '+593 912345678',
      'correo': 'lfernandez@mail.com',
      'servicio': 'Corte + tinte',
      'foto': 'https://randomuser.me/api/portraits/men/45.jpg'
    },
  ];

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _servicioController = TextEditingController();

  void _mostrarFormulario({int? index}) {
    if (index != null) {
      final c = clientes[index];
      _nombreController.text = c['nombre'] ?? '';
      _telefonoController.text = c['telefono'] ?? '';
      _correoController.text = c['correo'] ?? '';
      _servicioController.text = c['servicio'] ?? '';
    } else {
      _nombreController.clear();
      _telefonoController.clear();
      _correoController.clear();
      _servicioController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC), // beige claro
        title: Text(
          index == null ? "Agregar Nuevo Cliente 🧔" : "Editar Cliente",
          style: const TextStyle(
            color: Color(0xFF1A237E), // azul marino
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: "Nombre completo"),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: "Teléfono"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _correoController,
                decoration:
                    const InputDecoration(labelText: "Correo electrónico"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _servicioController,
                decoration: const InputDecoration(
                    labelText: "Servicio (Ej: Corte, Barba, Tinte)"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              foregroundColor: const Color(0xFFF5F5DC),
            ),
            onPressed: () {
              final nombre = _nombreController.text.trim();
              final telefono = _telefonoController.text.trim();
              final correo = _correoController.text.trim();
              final servicio = _servicioController.text.trim();

              if (nombre.isEmpty || telefono.isEmpty || correo.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Completa los campos requeridos')),
                );
                return;
              }

              setState(() {
                if (index == null) {
                  clientes.add({
                    'nombre': nombre,
                    'telefono': telefono,
                    'correo': correo,
                    'servicio':
                        servicio.isEmpty ? 'General' : servicio,
                    'foto':
                        'https://randomuser.me/api/portraits/men/${(clientes.length + 10) % 99}.jpg'
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$nombre agregado correctamente')),
                  );
                } else {
                  clientes[index] = {
                    'nombre': nombre,
                    'telefono': telefono,
                    'correo': correo,
                    'servicio': servicio.isEmpty
                        ? clientes[index]['servicio'] ?? 'General'
                        : servicio,
                    'foto': clientes[index]['foto'] ??
                        'https://randomuser.me/api/portraits/men/10.jpg'
                  };
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$nombre actualizado')),
                  );
                }
              });

              Navigator.pop(context);
              _nombreController.clear();
              _telefonoController.clear();
              _correoController.clear();
              _servicioController.clear();
            },
            child: Text(index == null ? "Guardar" : "Actualizar"),
          ),
        ],
      ),
    );
  }

  void _eliminarCliente(int index) {
    final nombre = clientes[index]['nombre'] ?? 'cliente';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC),
        title: const Text(
          'Eliminar cliente',
          style: TextStyle(color: Color(0xFF1A237E)),
        ),
        content: Text(
          '¿Deseas eliminar a $nombre? Esta acción no se puede deshacer.',
          style: const TextStyle(color: Color(0xFF424242)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white),
            onPressed: () {
              setState(() => clientes.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$nombre eliminado')));
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _servicioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6), // blanco hueso
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          "Clientes Registrados",
          style: TextStyle(color: Color(0xFFF5F5DC)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFF5F5DC)),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lista actualizada')));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE0C097),
        foregroundColor: const Color(0xFF1A237E),
        onPressed: () => _mostrarFormulario(),
        child: const Icon(Icons.person_add),
      ),
      body: clientes.isEmpty
          ? const Center(
              child: Text(
                "No hay clientes registrados.\nPresiona el botón + para agregar uno.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                return Card(
                  color: const Color(0xFFF5F5DC), // beige claro
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(cliente['foto'] ?? ''),
                    ),
                    title: Text(
                      cliente['nombre'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    subtitle: Text(
                      '📞 ${cliente['telefono']}\n✉️ ${cliente['correo']}\n💈 Servicio: ${cliente['servicio'] ?? 'General'}',
                      style: const TextStyle(color: Color(0xFF424242)),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Color(0xFF455A64)),
                            onPressed: () => _mostrarFormulario(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () => _eliminarCliente(index),
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
