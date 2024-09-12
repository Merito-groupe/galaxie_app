import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/ShopProfil.dart';
import 'package:galaxie_app/pages/Produits/showListProd.dart';
import 'package:galaxie_app/pages/onboarding/Onboarding.dart';
 

class Maboutique extends StatefulWidget {
  const Maboutique({super.key});

  @override
  State<Maboutique> createState() => _MaboutiqueState();
}

class _MaboutiqueState extends State<Maboutique> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ajoutez cette ligne
      home: DefaultTabController(
        length: 4,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Ma Boutique'),
              bottom: const TabBar(
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  Tab(
                    child: Text('Boutique'),
                  ),
                  Tab(
                    child: Text('Produits'),
                  ),
                  Tab(
                    child: Text('Commandes'),
                  ),
                  Tab(
                    child: Text('Finances'),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ShopProfil(),
                ListeProdsView(),
                // CommandeProduit(),
                   OnboardingScreen(),
                OnboardingScreen(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
