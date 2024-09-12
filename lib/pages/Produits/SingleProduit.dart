import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleProd extends StatelessWidget {
  final String prodName;
  final String prodUrlImg;
  final String prixUnitaire;
  final String prodReduction;
  final String prodDetailles;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  SingleProd(
      {required this.prodName,
      required this.prodDetailles,
      required this.prodReduction,
      required this.prixUnitaire,
      required this.prodUrlImg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(227, 255, 255, 255),
      appBar: AppBar(
        title: Text(prodName),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Acheter'),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: false,
                  context: context,
                  builder: (ctx) => ProdViewSheet(
                        prixUnitaire: prixUnitaire,
                        prodUrlImg: prodUrlImg,
                        prodName: prodName,
                      ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(prodUrlImg),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alignement de départ
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 12),
                  padding: const EdgeInsets.only(
                      bottom: 2, left: 12, right: 23, top: 0),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Text(
                    prodName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 2, right: 10),
                  padding: const EdgeInsets.only(
                      bottom: 2, left: 23, right: 23, top: 3),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          " $prixUnitaire CDF",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Spacer(), // Prend l'espace restant
                      Container(
                        child: Text(
                          "$prodReduction CDF",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Color.fromARGB(137, 255, 0, 0)),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(
                      bottom: 2, left: 12, right: 23, top: 0),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Text(
                    prodDetailles,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProdViewSheet extends StatefulWidget {
  final String prixUnitaire;
  final String prodUrlImg;
  final String prodName;

  ProdViewSheet({
    required this.prixUnitaire,
    required this.prodUrlImg,
    required this.prodName,
  });

  @override
  _ProdViewSheetState createState() => _ProdViewSheetState();
}

class _ProdViewSheetState extends State<ProdViewSheet> {
  int quantity = 1;
  String selectedColor = 'Rouge'; // Valeur par défaut
  String selectedSize = 'M'; // Valeur par défaut

  List<String> colors = [
    'Rouge',
    'Vert',
    'Bleu'
  ]; // Liste des couleurs disponibles
  List<String> sizes = ['S', 'M', 'L', 'XL']; // Liste des tailles disponibles

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void confirmOrder() async {
    // Obtenir l'ID de l'utilisateur actuellement connecté
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userId != null && userEmail != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .add({
        'color': selectedColor,
        'size': selectedSize,
        'quantity': quantity,
        'imageUrl': widget.prodUrlImg,
        'productName': widget.prodName,
        'productPrice': widget.prixUnitaire,
        'userEmail': userEmail, // Ajouter l'adresse e-mail de l'utilisateur
        // Ajouter d'autres détails si nécessaire
      });

      // Autres actions après confirmation, comme fermer le bas de page
      Navigator.of(context).pop();
    } else {
      print(
          "L'utilisateur n'est pas connecté."); // Gérer le cas où l'utilisateur n'est pas connecté
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construisez votre interface utilisateur ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Détaille du produit'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Image.network(widget.prodUrlImg),
              title: Text(
                "${widget.prixUnitaire} CDF",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            DropdownButton<String>(
              value: selectedColor,
              onChanged: (String? newValue) {
                setState(() {
                  selectedColor = newValue!;
                });
              },
              items: colors.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedSize,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSize = newValue!;
                });
              },
              items: sizes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrement,
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: increment,
                ),
              ],
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: Color.fromARGB(218, 190, 58, 32),
                  textStyle: TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "CONFIRMER",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: confirmOrder,
              ),
            )
          ],
        ),
      ),
    );
  }
}








