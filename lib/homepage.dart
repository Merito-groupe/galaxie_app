import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Categorie/Categories.dart';
import 'package:galaxie_app/pages/Maison/Maison.dart';
import 'package:galaxie_app/pages/Panier/PanierScreen.dart';
import 'package:galaxie_app/pages/ParametrePage.dart';

class HomePage extends StatefulWidget {
   final User user;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex = 0;

      final _pages = [
    const Maison(), // Replace with actual pages
    const CategorieProduits (),
    const PanierScreen(),
    const ParametrePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
            label: 'Paramètre',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

 