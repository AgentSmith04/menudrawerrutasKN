import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSPage extends StatefulWidget {
  const GPSPage({super.key});

  @override
  State<GPSPage> createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  String locationMessage = "Ubicación no obtenida";

  // 🔹 Solicita permisos y obtiene la ubicación
  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "El servicio de ubicación está desactivado";
      });
      return;
    }

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

    // 🔹 Obtiene la posición actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final newPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPosition;
      locationMessage =
          "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
    });

    // 🔹 Mueve la cámara del mapa a la nueva posición
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(newPosition, 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS / Ubicación 📍"),
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentPosition == null
                ? const Center(
                    child: Text(
                      "Presiona el botón para obtener tu ubicación",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("ubicacion_actual"),
                        position: _currentPosition!,
                        infoWindow:
                            const InfoWindow(title: "Tu ubicación actual"),
                      ),
                    },
                    onMapCreated: (controller) => _mapController = controller,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
          ),
          Container(
            color: const Color(0xFF1B263B),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                Text(
                  locationMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _getLocation,
                  icon: const Icon(Icons.location_on),
                  label: const Text("Obtener ubicación"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1B263B),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
