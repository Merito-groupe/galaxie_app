import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdresseLivraison extends StatefulWidget {
  const AdresseLivraison({super.key});

  @override
  State<AdresseLivraison> createState() => _AdresseLivraisonState();
}

class _AdresseLivraisonState extends State<AdresseLivraison> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  String? _fullName;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _loadUserData();
  }

  // Charger les données utilisateur depuis Firestore
  Future<void> _loadUserData() async {
    if (user != null) {
      // Récupérer les informations de la collection 'clientProfil'
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('clientProfil')
          .doc(user!.uid)
          .get();

      if (userProfile.exists) {
        Map<String, dynamic>? data =
            userProfile.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            _fullName = data['fullName'] ?? 'Nom non disponible';
          });
        }

        // Charger l'adresse de livraison à partir de la sous-collection
        DocumentSnapshot addressSnapshot = await FirebaseFirestore.instance
            .collection('clientProfil')
            .doc(user!.uid)
            .collection('adresseLivraison')
            .doc('adresse')
            .get();

        if (addressSnapshot.exists) {
          Map<String, dynamic>? addressData =
              addressSnapshot.data() as Map<String, dynamic>?;
          if (addressData != null) {
            _addressController.text = addressData['address'] ?? '';
          }
        }
      }
    }
  }

  // Sauvegarder l'adresse de livraison dans Firestore
  Future<void> _saveDeliveryAddress() async {
    if (_formKey.currentState!.validate() && user != null) {
      await FirebaseFirestore.instance
          .collection('clientProfil')
          .doc(user!.uid)
          .collection('adresseLivraison')
          .doc('adresse')
          .set({
        'address': _addressController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Adresse de livraison mise à jour avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adresse de Livraison'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_fullName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Champ pour l'adresse de livraison
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Mon adresse de livraison',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: null, // Permet au texte de prendre plusieurs lignes
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse de livraison';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _saveDeliveryAddress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Enregistrer l\'adresse',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
