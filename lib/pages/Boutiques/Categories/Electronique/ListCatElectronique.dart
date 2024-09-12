import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecAccessoirInfo.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecAppMenager.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecCasque.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecOutils.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecProdTele.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Electronique/ElecSacsEtuis.dart';
 
class ListCatElectroniqueScreen extends StatefulWidget {
  const ListCatElectroniqueScreen({super.key});

  @override
  State<ListCatElectroniqueScreen> createState() => _ListCatElectroniqueScreenState();
}

class _ListCatElectroniqueScreenState extends State<ListCatElectroniqueScreen> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Électrique'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sacs & Étuis'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Casques'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Produits pour Téléphone'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Outils'),
                  )),
                  
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Appareils Ménagers'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Accessoires Informatiques'),
                  )),
                   
                ],
              ),
            ),
            body: const TabBarView(
              children: [
              ElecSacsEtuisScreen(),
              ElecCasqueScreen(),
              ElecProdTeleScreen(),
              ElecOutilsScreen(),
              ElecAppMenagerScreen(),
              ElecAccessoirInfoScreen(),




                
                
              ],
            ),
          );
        }),
      ),
    );
  }
}
