import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyLevres.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyMaquillages.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyOutils.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyPerruques.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautySoinsCapillaire.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautySoinsPeau.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyVisage.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/BeautyYeux.dart';
 

class ListCatBeauty extends StatefulWidget {
  const ListCatBeauty({super.key});

  @override
  State<ListCatBeauty> createState() => _ListCatBeautyState();
}

class _ListCatBeautyState extends State<ListCatBeauty> {
Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 7,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Beauté'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Yeux'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Visage'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Lèvres'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Outils'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Soins de peau'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Soins capillaires'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Perruques'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Maquillages'),
                  )),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
               BeautyYeuxScreen(),
               BeautyVisageScreen(),
               BeautyLevresScreen(),
               BeautyOutilsScreen(),
               BeautySoinsPeauScreen(),
               BeautySoinsCapillaire(),
               BeautyPerruquesScreen(),
               BeautyMaquillagesScreen()
               
                
                
              ],
            ),
          );
        }),
      ),
    );
  }
}
