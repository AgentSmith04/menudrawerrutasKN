import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Página principal del lector QR 📱
class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isNavigating = false; // 🔹 Evita abrir varias veces la pantalla

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isNavigating) return; // Evita múltiples detecciones seguidas

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final codigo = barcodes.first.rawValue ?? "Código no válido";
      setState(() => _isNavigating = true);

      // 🔹 Navega a la pantalla del resultado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoQRPage(codigo: codigo),
        ),
      ).then((_) {
        // 🔹 Al volver, permite escanear de nuevo
        setState(() => _isNavigating = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escáner QR 🔍"),
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35, // cuadrado grande
          height: MediaQuery.of(context).size.width * 0.35,
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
              onDetect: _onDetect,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1B263B),
    );
  }
}

// 🔹 Nueva pantalla para mostrar el resultado del QR
class ResultadoQRPage extends StatelessWidget {
  final String codigo;

  const ResultadoQRPage({super.key, required this.codigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("Resultado del Escaneo"),
        backgroundColor: const Color(0xFF1B263B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF415A77),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.qr_code_2, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Código escaneado:",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                codigo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Volver al escáner"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B263B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
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
}
