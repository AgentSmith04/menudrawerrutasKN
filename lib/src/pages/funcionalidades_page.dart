import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // ✅ Compatible con web
import 'dart:io';

class FuncionalidadesPage extends StatefulWidget {
  const FuncionalidadesPage({super.key});

  @override
  State<FuncionalidadesPage> createState() => _FuncionalidadesPageState();
}

class _FuncionalidadesPageState extends State<FuncionalidadesPage> {
  String locationMessage = "Ubicación no disponible";
  String qrText = "Aún no se ha escaneado un código";

  // 📍 Obtener ubicación actual
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si los servicios de ubicación están activados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Los servicios de ubicación están desactivados";
      });
      return;
    }

    // Verifica y solicita permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Permiso de ubicación denegado";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Permiso de ubicación denegado permanentemente";
      });
      return;
    }

    // Obtiene la posición actual
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      locationMessage = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    });
  }

  // 📷 Abrir cámara
  Future<void> _openCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPreviewScreen(camera: firstCamera),
      ),
    );
  }

  // 🔲 Escanear código QR
  Future<void> _scanQR() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRViewExample(), // ✅ Nueva versión
      ),
    ).then((value) {
      if (value != null) {
        setState(() => qrText = value.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cámara, GPS y QR"),
        backgroundColor: const Color(0xFF5E35B1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 📷 Botón para abrir la cámara
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text("Abrir cámara"),
              onPressed: _openCamera,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2)),
            ),
            const SizedBox(height: 15),

            // 📍 Botón para obtener la ubicación
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Obtener ubicación"),
              onPressed: _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2)),
            ),
            const SizedBox(height: 15),

            // 🔲 Botón para escanear código QR
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code),
              label: const Text("Escanear QR"),
              onPressed: _scanQR,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2)),
            ),
            const SizedBox(height: 30),

            // Muestra la ubicación y el resultado del QR
            Text(locationMessage),
            const SizedBox(height: 10),
            Text("Resultado del QR: $qrText"),
          ],
        ),
      ),
    );
  }
}

// 📷 Pantalla de cámara
class CameraPreviewScreen extends StatelessWidget {
  final CameraDescription camera;
  const CameraPreviewScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    final controller = CameraController(camera, ResolutionPreset.medium);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: const Text("Vista de Cámara")),
            body: CameraPreview(controller),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// 🔲 Pantalla para escanear código QR (versión compatible con Web)
class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  String scannedCode = 'Aún no se ha escaneado ningún código';
  double zoomFactor = 1.0; // 🔍 Nivel inicial de zoom

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner QR'),
        backgroundColor: const Color(0xFF5E35B1),
        actions: [
          // 🔍 Botones para ajustar el zoom manualmente
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              setState(() {
                if (zoomFactor < 2.0) zoomFactor += 0.2;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                if (zoomFactor > 0.6) zoomFactor -= 0.2;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Muestra la cámara para escanear el QR
          Expanded(
            flex: 4,
            child: Transform.scale(
              // 📏 Aplica un zoom suave sin recargar la cámara
              scale: zoomFactor,
              child: MobileScanner(
                fit: BoxFit.cover,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String code =
                        barcodes.first.rawValue ?? 'Código no válido';
                    setState(() => scannedCode = code);
                    Navigator.pop(context, code); // 🔙 Devuelve el código leído
                  }
                },
              ),
            ),
          ),

          // Muestra el código escaneado
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scannedCode,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
