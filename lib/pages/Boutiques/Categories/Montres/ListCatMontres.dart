import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Montres/MontreMecanique.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Montres/MontreNumerique.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Montres/MontrePoche.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Montres/MontreQuartz.dart';
 

class ListCatMontresScreen extends StatefulWidget {
  const ListCatMontresScreen({super.key});

  @override
  State<ListCatMontresScreen> createState() => _ListCatMontresScreenState();
}

class _ListCatMontresScreenState extends State<ListCatMontresScreen> {
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Montres'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Montres Numériques'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Montres Mécaniques'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Montres à Quartz'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Montres de Poche'),
                  )),
                  
                ],
              ),
            ),
            body: const TabBarView(
              children: [
              MontreNumeriqueScreen(),
              MontreMecaniqueScreen(),
              MontreQuartzScreen(),
              MontrePocheScreen(),
  
              ],
            ),
          );
        }),
      ),
    );
  }
}
