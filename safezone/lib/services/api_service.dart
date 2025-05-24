import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  static Future<void> shareLocation(double lat, double lng, String userId) async {
    await FirebaseFirestore.instance.collection('locations').doc(userId).set({
      'latitude': lat,
      'longitude': lng,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> getAllUserLocations() {
    return FirebaseFirestore.instance.collection('locations').snapshots();
  }
}
