import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Beauty/ListCatBeauty.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Bijoux/ListCatBijoux.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Chaussure/ListCatChaussure.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Enfants/ListCatEnfants.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Habillement/ListCatHabillement.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Maison/ListCatMaison.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Montres/ListCatMontres.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sacs/ListCatSac.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Sports/ListCatSports.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Vehicules/ListCatVehicule.dart';
import 'package:galaxie_app/pages/Boutiques/Categories/Wedding/ListCatWedding.dart';
 
 
class Categories extends StatefulWidget {
  final User? user;

  const Categories({Key? key, this.user}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
//  final User? user;
}

class _CategoriesState extends State<Categories> {
 final List<Map<String, dynamic>> categories = [
    {
      'name': 'Habillement',
      'icon': Icons.category,
      'page': ListCatHabillement()
    },
    {'name': 'Sacs', 'icon': Icons.backpack, 'page': ListCatSacScreen()},
    {'name': 'Chaussure', 'icon': Icons.sports_soccer, 'page': ListCatChaussures()},
    {'name': 'Beauté', 'icon': Icons.brush, 'page': ListCatBeauty()},
    {'name': 'Bijoux', 'icon': Icons.watch, 'page': ListCatBijouxScreen()},
    {'name': 'Montres', 'icon': Icons.watch, 'page': ListCatMontresScreen()},
    {
      'name': 'Electronique',
      'icon': Icons.electrical_services,
      'page':  ListCatMaisonScreen()
    },
    {'name': 'Maison', 'icon': Icons.home, 'page': ListCatMaisonScreen()},
    {
      'name': 'Vehicules',
      'icon': Icons.directions_car,
      'page':  ListCatVehiculeScreen(),
    },
    {'name': 'Enfants', 'icon': Icons.child_care, 'page': ListCatEnfantsScreen()},
    {'name': 'Wedding', 'icon': Icons.cake, 'page': ListCatWeddingScreen()},
    {'name': 'Sports', 'icon': Icons.sports, 'page': ListCatSportScreen()},
];



  

  int selectedIndex = 0;  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(

            onTap: () {
              setState(() {
                selectedIndex = index;  
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => categories[index][
                      'page'],  
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   categories[index]['icon'],
                  //   size: 30,
                  //   color: isSelected ? Colors.white : Colors.black,
                  // ),
                  // SizedBox(
                  //     height: 5), // Add some spacing between the icon and text
                  
                  Text(
                    categories[index]['name'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
