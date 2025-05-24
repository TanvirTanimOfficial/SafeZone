import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/api_service.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _shareLocation(BuildContext context) async {
    try {
      Position position = await LocationService.getCurrentLocation();
      await ApiService.shareLocation(position.latitude, position.longitude, 'user_1');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location shared successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing location: \$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeZone Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _shareLocation(context),
              child: const Text('One-Click Location Share'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/map'),
              child: const Text('View Live User Map'),
            ),
          ],
        ),
      ),
    );
  }
}