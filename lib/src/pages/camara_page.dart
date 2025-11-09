import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Página solo para uso de cámara (sin lector QR)
class CamaraPage extends StatefulWidget {
  const CamaraPage({super.key});

  @override
  State<CamaraPage> createState() => _CamaraPageState();
}

class _CamaraPageState extends State<CamaraPage> {
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  double _zoom = 0.0; // Nivel de zoom inicial

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateZoom(double value) {
    setState(() {
      _zoom = value;
    });
    _controller.setZoomScale(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uso de Cámara 📷"),
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔹 Vista de cámara centrada (sin lector)
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.60, // 85% del ancho
              height: MediaQuery.of(context).size.height * 0.65, // 60% del alto
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MobileScanner(
                  controller: _controller,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 🔹 Control de zoom
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Zoom",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: _zoom,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: (_zoom * 10).toStringAsFixed(1),
                onChanged: _updateZoom,
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1B263B),
    );
  }
}
