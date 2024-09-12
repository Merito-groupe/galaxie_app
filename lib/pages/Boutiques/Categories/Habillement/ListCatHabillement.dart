import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/African.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/AutresHabits.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/CombinaisonFemme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/PantalonsHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/TopsTeeFemme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/TopsTeeHomme.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/robes.dart';
 

class ListCatHabillement extends StatefulWidget {
  const ListCatHabillement({super.key});

  @override
  State<ListCatHabillement> createState() => _ListCatHabillementState();
}

class _ListCatHabillementState extends State<ListCatHabillement> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Habillements'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Robes'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tops et Tee Femme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Combinaison et Pants'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('African'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tops et Tee Homme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Pantalos Homme'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Autres Habits'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                RobesScreen(),
                TopsTeeFemmeScreen(),
                CombinaisonFemme(),
                AfricanScreen(),
                TopsTeeHommeScreen(),
                PantalosHommesScreen(),
                AutreHabitScreen(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
