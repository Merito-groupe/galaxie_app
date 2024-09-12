import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/SportCampingRandonnee.dart.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/SportCyclisme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/SportHauts.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/SportMaillots.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/SportPantalons.dart';
 

class ListCatSportScreen extends StatefulWidget {
  const ListCatSportScreen({super.key});

  @override
  State<ListCatSportScreen> createState() => _ListCatSportScreenState();
}

class _ListCatSportScreenState extends State<ListCatSportScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sports'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Pantalons & Robes'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hauts'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Maillots'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Camping & Randonnée'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Cyclisme'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                SportPantalonsScreen(),
                SportHautsScreen(),
                SportMaillotsScreen(),
                SportCampingRandonneeScreen(),
                SportCyclisme(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
