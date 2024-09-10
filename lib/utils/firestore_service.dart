import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galaxie_app/models/advertisement_model.dart';
 
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ajoute une nouvelle publicité dans la collection 'advertisements'
  Future<void> addAdvertisement(
    String title,
    String advertiserName,
    String url,
    String city,
    String routes,
    DateTime startTime,
    DateTime endTime, int numberOfVehicles,
  ) async {
    try {
      await _db.collection('advertisements').add({
        'title': title,
        'advertiserName': advertiserName,
        'url': url,
        'city': city,
        'routes': routes,
        'startTime': Timestamp.fromDate(startTime),
        'endTime': Timestamp.fromDate(endTime),
      });
    } catch (e) {
      print('Error adding advertisement: $e');
      rethrow;
    }
  }

  // Récupère toutes les publicités de la collection 'advertisements'
  Stream<List<Advertisement>> getAdvertisements() {
    return _db.collection('advertisements').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Advertisement.fromDocument(doc)).toList();
    });
  }

  // Récupère une publicité par ID
  Future<Advertisement> getAdvertisementById(String id) async {
    try {
      DocumentSnapshot doc = await _db.collection('advertisements').doc(id).get();
      return Advertisement.fromDocument(doc);
    } catch (e) {
      print('Error getting advertisement: $e');
      rethrow;
    }
  }

  // Met à jour une publicité existante
  Future<void> updateAdvertisement(
    String id,
    String title,
    String advertiserName,
    String? url,
    String city,
    String routes,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      await _db.collection('advertisements').doc(id).update({
        'title': title,
        'advertiserName': advertiserName,
        'url': url,
        'city': city,
        'routes': routes,
        'startTime': Timestamp.fromDate(startTime),
        'endTime': Timestamp.fromDate(endTime),
      });
    } catch (e) {
      print('Error updating advertisement: $e');
      rethrow;
    }
  }

  // Supprime une publicité par ID
  Future<void> deleteAdvertisement(String id) async {
    try {
      await _db.collection('advertisements').doc(id).delete();
    } catch (e) {
      print('Error deleting advertisement: $e');
      rethrow;
    }
  }

  // Ajoute un nouveau profil de conducteur dans la collection 'drivers'
  Future<void> addDriverProfile(Map<String, dynamic> profileData) async {
    try {
      await _db.collection('drivers').add(profileData);
    } catch (e) {
      print('Erreur lors de l\'ajout du profil: $e');
      throw e;
    }
  }
}
