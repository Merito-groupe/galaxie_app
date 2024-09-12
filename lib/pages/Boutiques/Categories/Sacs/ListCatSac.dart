import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacAutres.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacCollection.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacEpaule.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacPortefeuille.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacaDos.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/SacaMain.dart';
 

class ListCatSacScreen extends StatefulWidget {
  const ListCatSacScreen({super.key});

  @override
  State<ListCatSacScreen> createState() => _ListCatSacScreenState();
}

class _ListCatSacScreenState extends State<ListCatSacScreen> {
  @override
 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sacs'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sac à main'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Collection'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Portefeuilles'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sacs à dos'),
                  )),
                    Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sacs à épaule'),
                  )),
                   Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autres Sacs'),
                  )),
                  
                  
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                SacEpauleScreen(),
                SacaMainScreen(),
                SacCollectionScreen(),
                SacPortefeuilleScreen(),

                SacaDosScreen(),
                SacEpauleScreen(),
                AutreSacScreen(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
