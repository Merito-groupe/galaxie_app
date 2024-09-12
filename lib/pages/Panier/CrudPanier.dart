 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudPanier extends StatelessWidget {
  const CrudPanier({Key? key}) : super(key: key);

  Future<void> supprimerDocument(String userId, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Erreur lors de la suppression du document: $e');
    }
  }

  Future<void> mettreAjourDocument(String userId, String docId, Map<String, dynamic> newData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .doc(docId)
          .update(newData);
    } catch (e) {
      print('Erreur lors de la mise à jour du document: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 
  
}
