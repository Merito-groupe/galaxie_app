 import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/VehiculeAccAuto.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/VehiculeAccMoto.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/VehiculeElectro.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/VehiculeMaintenance.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/VehiculeProdSecurite.dart';
 

class ListCatVehiculeScreen extends StatefulWidget {
  const ListCatVehiculeScreen({super.key});

  @override
  State<ListCatVehiculeScreen> createState() => _ListCatVehiculeScreenState();
}

class _ListCatVehiculeScreenState extends State<ListCatVehiculeScreen> {
   

   @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Vehicule'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Electronique Pour Vehicule'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Accessoire d\'automobiles'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Accessoire pour Moto'),
                  )),
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Outils de maintenances'),
                  )),
                  
                  
                  Tab(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Produit de Sécurité'),
                  )),
                   
                ],
              ),
            ),
            body: const TabBarView(
        children: [
            VehiculeElectroScreen(),
            VehiculeAccAutoScreen(),
            VehiculeAccAutoScreen(),
            VehiculeAccMotoScreen(),
            VehiculeMaintenanceScreen(),
            VehiculeProdSecuriteScreen()
             ],
            ),
          );
        }),
      ),
    );
  }
}
