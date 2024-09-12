import 'package:flutter/material.dart';

class ProduitView extends StatelessWidget {
  final String prodName;
  final String prodUrlImg;
  final String prixUnitaire;
  final String prodReduction;
  final String prodDetailles;

  ProduitView(
      {required this.prodName,
      required this.prodDetailles,
      required this.prodReduction,
      required this.prixUnitaire,
      required this.prodUrlImg});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(228, 255, 255, 255),
      appBar: AppBar(
        title: Text(prodName),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Acheter'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Salut'),
                    content: const Text(
                        'Ceci est une alerte qui sera changer par un bottomsheet'),
                    actions: [
                      TextButton(
                        child: const Text('Fermer'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
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
        crossAxisAlignment: CrossAxisAlignment.start, // Alignement de départ
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top:12),
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
