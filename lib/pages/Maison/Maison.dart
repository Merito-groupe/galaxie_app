import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/StandAlonProduct/ProductDetailsPage.dart';

class Maison extends StatefulWidget {
  const Maison({super.key});

  @override
  State<Maison> createState() => _MaisonState();
}

class _MaisonState extends State<Maison> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _searchQuery = ''; // Stocke la requête de recherche

  void _searchProducts(String query) async {
    setState(() {
      _searchQuery = query;
    });

    final QuerySnapshot nameQuery = await _firestore
        .collection('produits')
        .where('nom', isGreaterThanOrEqualTo: query)
        .where('nom', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    final QuerySnapshot categoryQuery = await _firestore
        .collection('produits')
        .where('categorie', isEqualTo: query)
        .get();

    if (nameQuery.docs.isNotEmpty) {
      _showBottomSheet(nameQuery.docs);
    } else if (categoryQuery.docs.isNotEmpty) {
      _showBottomSheet(categoryQuery.docs);
    } else {
      _showNoResultsBottomSheet();
    }
  }

  void _showBottomSheet(List<QueryDocumentSnapshot> products) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color.fromARGB(
              255, 249, 239, 219), // Couleur de fond de la BottomSheet
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final produit = products[index];
              final String imageUrl = produit['imageUrl'] ?? '';
              final String nom = produit['nom'] ?? 'Produit';
              final String categorie = produit['categorie'] ?? 'Inconnu';
              final int prix = produit['prix'] ?? 0;
              final int quantite = produit['quantite'] ?? 0;
              final String description =
                  produit['description'] ?? 'Aucun déscription';

              return ListTile(
                leading: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                ),
                title: Text(nom),
                subtitle: Text('Prix: $prix FC'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        imageUrl: imageUrl,
                        nom: nom,
                        categorie: categorie,
                        prix: prix,
                        quantite: quantite,
                        description: description,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showNoResultsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color.fromARGB(255, 245, 210, 146),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Aucun produit trouvé.',
                style: TextStyle(
                  color: Colors.white, // Couleur du texte
                  fontSize: 18, // Taille du texte
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: const Color(0xFFD78914),
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Maison GALAXY',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'vous cherchez quoi?',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 5, 5, 5),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              _searchProducts(_searchQuery);
                            },
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      _searchQuery =
                          value; // Mettre à jour la requête de recherche
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('produits').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }

            final produits = snapshot.data?.docs ?? [];
            if (produits.isEmpty) {
              return const Center(child: Text('Aucun produit disponible.'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: produits.length,
              itemBuilder: (context, index) {
                final produit = produits[index];
                final String imageUrl = produit['imageUrl'] ?? '';
                final String nom = produit['nom'] ?? 'Produit';
                final String categorie = produit['categorie'] ?? 'Inconnu';
                final int prix = produit['prix'] ?? 0;
                final int quantite = produit['quantite'] ?? 0;
                final String description =
                    produit['description'] ?? 'Aucun déscription';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          imageUrl: imageUrl,
                          nom: nom,
                          categorie: categorie,
                          prix: prix,
                          quantite: quantite,
                          description: description,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      color: const Color.fromARGB(255, 245, 210, 146),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(5)),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image, size: 100),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              nom,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              '$prix FC',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.teal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}