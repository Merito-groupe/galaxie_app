import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/driver_model.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDriverProfile(Driver driver) async {
    try {
      await _firestore.collection('driver').doc('profile').set(driver.toMap());
    } catch (e) {
      print('Erreur lors de l\'enregistrement du profil : $e');
      throw e;
    }
  }
 
}
