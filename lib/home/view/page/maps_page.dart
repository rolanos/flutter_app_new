import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Polyline> _polyline = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.2567, 76.9286), // Координаты Алматы
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Карты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.pink,
      ),
      body: GoogleMap(
        mapType: MapType.normal, // Изменяем тип карты на обычную карту
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          const Marker(
            markerId: MarkerId('almaty'),
            position: LatLng(43.2567, 76.9286),
            infoWindow: InfoWindow(title: 'Алматы'),
          ),
        },
        polylines: _polyline, // Добавляем полилинию на карту
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addRandomRoute, // Изменяем функцию для добавления случайного маршрута
        label: const Text('Случайный маршрут'),
        icon: const Icon(Icons.directions),
      ),
    );
  }

  // Добавляем случайный маршрут на карту
  void _addRandomRoute() {
    setState(() {
      _polyline.clear(); // Очищаем старые маршруты
      _polyline.add(
        Polyline(
          polylineId: const PolylineId('randomRoute'),
          points: _createRandomRoute(), // Генерируем новый случайный маршрут
          color: Colors.blue, // Устанавливаем цвет маршрута
          width: 5, // Устанавливаем ширину линии
        ),
      );
    });
  }

  // Создаем случайный маршрут (список точек)
  List<LatLng> _createRandomRoute() {
    final random = Random();
    final List<LatLng> points = [];

    for (var i = 0; i < 10; i++) {
      points.add(
        LatLng(
          43.25 + random.nextDouble() * 0.01,
          76.92 + random.nextDouble() * 0.01,
        ),
      );
    }
    return points;
  }
}
