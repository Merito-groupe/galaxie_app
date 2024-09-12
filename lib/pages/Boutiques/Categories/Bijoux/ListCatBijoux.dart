import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxAutres.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxBag.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxBoucleOreilles.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxBracelets.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxEnsBijoux.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/BijouxPorteCles.dart';
 

class ListCatBijouxScreen extends StatefulWidget {
  const ListCatBijouxScreen({super.key});

  @override
  State<ListCatBijouxScreen> createState() => _ListCatBijouxScreenState();
}

class _ListCatBijouxScreenState extends State<ListCatBijouxScreen> {
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Collier'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bagues'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bracelets'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Boucles d’oreilles'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ensembles de Bijoux'),
                  )),
                   
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Porte-clés'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autres Bijoux'),
                  )),
                   
                ],
              ),
            ),
            body: const TabBarView(
              children: [
              BijouxBagueScreen(),
              BijouxBraceletsScreen(),
              BijouxBoucleOreillesScreen(),
              BijouxEnsBijouxScreen(),
              BijouxPorteClesScreen(),
              BijouxAutresScreen(),
                
              ],
            ),
          );
        }),
      ),
    );
  }
}