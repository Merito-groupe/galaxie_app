import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/CommandeClient.dart';
import 'package:galaxie_app/pages/InviterPages.dart';
import 'package:galaxie_app/pages/NosProduits.dart';
import 'package:galaxie_app/pages/RessourceHumaine.dart';

class Administration extends StatefulWidget {
  const Administration({super.key});

  @override
  State<Administration> createState() => _AdministrationState();
}

class _AdministrationState extends State<Administration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ajoutez cette ligne
      home: DefaultTabController(
        length: 3,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Administration Dashboard'),
              bottom: const TabBar(
                labelPadding: EdgeInsets.all(1),
                tabs: [
                  Tab(
                    child: Text('Nos Produits'),
                  ),
                  Tab(
                    child: Text('Commande Client'),
                  ),
                  Tab(
                    child: Text('Agents'),
                  ),
                   
                ],
              ),
            ),
            body:     TabBarView(
              children: [
                ProductManager(),
                CommandeClient(),
                RessourceHumaine(),
               ],
            ),
          );
        }),
      ),
    );
  }
}
