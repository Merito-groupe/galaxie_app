import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/WeddingAccessoir.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/WeddingRobesMariee.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/WeddingRobesSoiree.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/WeddingVestHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/WeddingVesteFemme.dart';
 

class ListCatWeddingScreen extends StatefulWidget {
  const ListCatWeddingScreen({super.key});

  @override
  State<ListCatWeddingScreen> createState() => _ListCatWeddingScreenState();
}

class _ListCatWeddingScreenState extends State<ListCatWeddingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mariage'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Accessoires de Mariage'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Robes de Mariée'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Robes de Soirée'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Veste Homme'),
                  )),
                  Tab(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Veste Femme'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                WeddingAccessoirScreen(),
                WeddingRobesMarieeScreen(),
                WeddingRobesSoireeScreen(),
                WeddingVestHommeScreen(),
                WeddingVesteFemmeScreeen(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
