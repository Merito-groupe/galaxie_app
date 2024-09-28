import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/StandAlonProduct/ProductDetailsPage.dart';

class CategorieProduits extends StatefulWidget {
  const CategorieProduits({super.key});

  @override
  State<CategorieProduits> createState() => _CategorieProduitsState();
}

class _CategorieProduitsState extends State<CategorieProduits>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = [
    'Soins de la peau',
    'Maquillage',
    'Soins capillaires',
    'Parfums',
    'Soins du corps',
    'Hygiène dentaire',
    'Produits solaires',
    'Soins mains et ongles',
    'Déodorants, anti-transpirants',
    'Accessoires de beauté'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0), // Hauteur de l'AppBar
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
                const SizedBox(height: 4),
                Container(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Vous cherchez quoi?',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              // Action à définir pour le bouton de recherche
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
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: const Color.fromARGB(255, 255, 255, 255), // Couleur de l'onglet sélectionné
            unselectedLabelColor:
                const Color.fromARGB(255, 3, 3, 3),
                 // Couleur des onglets non sélectionnés
            indicator: BoxDecoration(
              color:Color.fromARGB(255, 249, 203, 134), // Couleur de fond de l'onglet actif
              borderRadius:BorderRadius.circular(4),
               // Arrondi pour un effet plus doux
            ),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: -10.0), 
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, 
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, 
            ),
             tabs: categories.map((categorie) {
              return Tab(
                text: categorie,
              );
            }).toList(),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F5F5), // Ajouter une couleur de fond
        padding: const EdgeInsets.all(2), // Ajouter du padding pour l'ensemble du contenu
        child: TabBarView(
          controller: _tabController,
          children: categories.map((categorie) {
            return CategoryProductsList(category: categorie);
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryProductsList extends StatelessWidget {
  final String category;
  const CategoryProductsList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('produits')
          .where('categorie', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        final produits = snapshot.data?.docs ?? [];
        if (produits.isEmpty) {
          return const Center(child: Text('Aucun produit trouvé.'));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Afficher 2 produits par ligne
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65, // Ajuster l'aspect des produits
          ),
          itemCount: produits.length,
          itemBuilder: (context, index) {
                final produit = produits[index];
                final String imageUrl = produit['imageUrl'] ?? '';
                final String nom = produit['nom'] ?? 'Produit';
                final String categorie = produit['categorie'] ?? 'Inconnu';
                final int prix = produit['prix'] ?? 0;
                final int quantite = produit['quantite'] ?? 0;

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
                          description: '',   
                        ),
                      ),
                    );
                  },
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(
                    8), // Ajouter des marges autour de la carte
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        nom,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
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
                          color: Color(0xFFD78914),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}