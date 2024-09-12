import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauAutresChaussuresHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauBasketFemme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauBasketHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauChaussuresVille.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauMocassin.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauNude.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauSandaleTongoHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ChauSandalesTongsFemme.dart';
 

class ListCatChaussures extends StatefulWidget {
  const ListCatChaussures({super.key});

  @override
  State<ListCatChaussures> createState() => _ListCatChaussuresState();
}

class _ListCatChaussuresState extends State<ListCatChaussures> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chaussures'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Chaussures Nudes'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sandales & Tongs Femme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Baskets Femme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Mocassins'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sandales & Tongs Hommes'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(' Chaussures de Ville'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Baskets Homme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autres Chaussures pour Hommes'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
              ChauNudeScreen(),
              ChauSandalesTongsFemmeScreen(),
              ChauBasketFemmeScreen(),
              ChauMocassinScreen(),
              ChauSandaleTongoHommeScreen(),
              ChauChaussuresVilleScreen(),
              ChauBasketHommeScreen(),
              ChauAutresChaussuresHommeScreen(),

                
                
              ],
            ),
          );
        }),
      ),
    );
  }
}
