import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantChaussureBebe.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantChaussureEnfants.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantJouerLoisir.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantSoinBebe.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantVetementBebe.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/EnfantVetementEnfants.dart';
 

class ListCatEnfantsScreen extends StatefulWidget {
  const ListCatEnfantsScreen({super.key});

  @override
  State<ListCatEnfantsScreen> createState() => _ListCatEnfantsScreenState();
}

class _ListCatEnfantsScreenState extends State<ListCatEnfantsScreen> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Enfants'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Jouets & Loisirs'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Soins Bébé'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(' Vêtements Bébé'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Vêtements Enfants'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Chaussures Bébé'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Chaussures Enfants'),
                  )),
                   
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                EnfantJouerLoisirScreen(),
                EnfantSoinBebeScreen(),
                EnfantVetementBebeScreen(),
                EnfantVetementEnfantsScreen(),
                EnfantChaussureBebeScreen(),
                EnfantChaussureEnfantsScreen()
               ],
            ),
          );
        }),
      ),
    );
  }
}
