import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/api_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    ApiService.getAllUserLocations().listen((snapshot) {
      final markers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(data['latitude'], data['longitude']),
          infoWindow: InfoWindow(title: doc.id),
        );
      }).toSet();

      setState(() {
        _markers.clear();
        _markers.addAll(markers);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live User Map')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.777176, 90.399452),
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}