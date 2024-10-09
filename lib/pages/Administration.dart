import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/CommandeClient.dart';
import 'package:galaxie_app/pages/NosProduits.dart';
import 'package:galaxie_app/pages/RessourceHumaine.dart';

class Administration extends StatefulWidget {
  const Administration({super.key});

  @override
  State<Administration> createState() => _AdministrationState();
}

class _AdministrationState extends State<Administration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Appliquer une couleur principale à l'ensemble de l'application
        primaryColor: Color(0xFFD78914),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD78914), // Couleur de l'AppBar
          centerTitle: true, // Centrer le titre
          elevation: 5, // Ombre sous l'AppBar
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, // Couleur du texte sélectionné
          unselectedLabelColor: Color.fromARGB(205, 0, 0, 0), // Couleur du texte non sélectionné
          labelStyle: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, // Style du texte sélectionné
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.normal, // Style du texte non sélectionné
          ),
          indicator: UnderlineTabIndicator( // Style de l'indicateur sous les tabs
            borderSide: BorderSide(width: 4.0, color: Color.fromARGB(255, 31, 127, 176)), // Couleur et épaisseur de l'indicateur
          ),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Administration Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Style du titre de l'AppBar
                  color: Colors.white, // Couleur du titre
                ),
              ),
              bottom: const TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 20), // Espacement des labels
                tabs: [
                  Tab(
                    icon: Icon(Icons.production_quantity_limits), // Ajouter une icône
                    text: 'Nos Produits',
                  ),
                  Tab(
                    icon: Icon(Icons.shopping_cart), // Ajouter une icône
                    text: 'Commande Client',
                  ),
                  Tab(
                    icon: Icon(Icons.people), // Ajouter une icône
                    text: 'Agents',
                  ),
                ],
              ),
            ),
            body:   TabBarView(
              children: [
                ProductManager(),
                const CommandeClient(),
                const RessourceHumaine(),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     // Ajouter une action ici
            //   },
            //   backgroundColor: Color(0xFFD78914), // Couleur du bouton
            //   child: const Icon(Icons.add), // Icône du bouton
            // ),
          );
        }),
      ),
    );
  }
}
