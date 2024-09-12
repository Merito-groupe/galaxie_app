import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonAutres.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonDecoration.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonNettoyage.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonRangementOrganisation.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonSalleBain.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonSalleMangerBar.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/MaisonTextile.dart';
 

class ListCatMaisonScreen extends StatefulWidget {
  const ListCatMaisonScreen({super.key});

  @override
  State<ListCatMaisonScreen> createState() => _ListCatMaisonScreenState();
}

class _ListCatMaisonScreenState extends State<ListCatMaisonScreen> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Maison'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Salle de Bain'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Décoration'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Rangement et Organisation'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Textile'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Outils de Nettoyage'),
                  )),
                  
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Salle à Manger & Bar'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autres'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
              MaisonSalleBainScreen(),
              MaisonDecorationScreen(),
              MaisonRangementOrganisationScreen(),
              MaisonTextileScreen(),
              MaisonNettoyageScreen(),
              MaisonSalleMangerBarScreen(),
              MaisonAutresScreen(),
             ],
            ),
          );
        }),
      ),
    );
  }
}
