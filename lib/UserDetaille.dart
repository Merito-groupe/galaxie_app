import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxie_app/pages/add_advertisement_page.dart';
import 'package:galaxie_app/pages/parametre_page.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int _currentIndex = 0;

  final _pages = [
    ParametrePage(),
    AddAdvertisementPage(),
    ParametrePage(),
    ParametrePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Hauteur de l'AppBar
        child: AppBar(
          backgroundColor: Color(0xFFD78914),
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
                      fontSize: 24, // Augmenter la taille de la police
                      fontWeight: FontWeight.bold, // Rendre le texte en gras
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 40,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: ' vous cherchez quoi?',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                            right: 0), // Ajouter un léger espace à droite
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                                255, 5, 5, 5), // Couleur de fond noire
                            border: Border(
                              right: BorderSide(
                                color: Colors.black, // Couleur de la bordure
                                width: 2.0, // Largeur de la bordure
                              ),
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.search,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                            onPressed: () {
                              // Action à effectuer lors du clic sur l'icône de recherche
                            },
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0), // Décalage à droite
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 216, 130, 1),
        unselectedItemColor: const Color.fromARGB(255, 74, 74, 74),
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 25),
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Maison',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètre', // Correction de la faute d'orthographe
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
