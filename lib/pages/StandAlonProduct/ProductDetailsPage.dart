
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String nom;
  final String categorie;
  final int prix;
  final int quantite;
  final String description;

  const ProductDetailsPage({
    Key? key,
    required this.imageUrl,
    required this.nom,
    required this.categorie,
    required this.prix,
    required this.quantite,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(nom),
        backgroundColor: const Color(0xFFD78914),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                imageUrl,
                height: screenHeight * 0.7, // Ajustez ce pourcentage pour modifier la hauteur de l'image
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
              const SizedBox(height: 10),
              Text(
                nom,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Catégorie: $categorie',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantité disponible: $quantite',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Prix: $prix FC',
                style: const TextStyle(fontSize: 18, color: Colors.teal),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                  '$description',
                  style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 6, 6, 6)),
                               ),
               ),
               
              Center(
                child: ElevatedButton(
                  onPressed: () => _ajouterAuPanier(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD78914),
                  ),
                  child: const Text('Ajouter au panier', 
                  style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
               
            ],
          ),
        ),
      ),
    );
  }

 
Future<void> _ajouterAuPanier(BuildContext context) async {
  int quantiteDemandee = 1; // Par défaut, quantité minimale

  // Affichage de la boîte de dialogue pour entrer la quantité
  await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
 
        title: const Center(
          child: Text(
            'Choisir la quantité',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal, // Couleur du titre
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quantité disponible : $quantite',
              style: const TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 0, 0, 0),
                 fontWeight: FontWeight.bold,
                 // Couleur du texte
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantité',
                labelStyle: const TextStyle(color: Colors.teal), // Couleur du label
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              initialValue: '1',
              onChanged: (value) {
                quantiteDemandee = int.tryParse(value) ?? 1;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.grey, // Couleur du bouton "Annuler"
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Annuler'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: const Color(0xFFD78914), // Couleur du bouton "Ajouter"
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Ajouter'),
            onPressed: () {
              Navigator.of(context).pop();
              _sauvegarderAuPanier(context, quantiteDemandee);
            },
          ),
        ],
      );
    },
  );
}
 
Future<void> _sauvegarderAuPanier(BuildContext context, int quantiteDemandee) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final String userId = user.uid;

    if (quantiteDemandee <= 0 || quantiteDemandee > quantite) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantité non valide'),
          duration: Duration(seconds: 2), // Durée de 10 secondes
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('paniers').add({
        'userId': userId,
        'nom': nom,
        'prixUnitaire': prix,
        'quantiteDemandee': quantiteDemandee,
        'imageUrl': imageUrl,
        'totalPrix': prix * quantiteDemandee,
        'dateAjout': Timestamp.now(),
      });

      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produit ajouté au panier avec succès'),
          duration: Duration(seconds: 5), // Durée de 10 secondes
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout du produit: $e'),
          duration: Duration(seconds: 3), // Durée de 10 secondes
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez vous connecter pour ajouter au panier'),
        duration: Duration(seconds: 2), // Durée de 10 secondes
      ),
    );
  }
}


  
}
