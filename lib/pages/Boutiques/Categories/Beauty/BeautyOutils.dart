import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Produits/SingleProduit.dart';
 
class BeautyOutilsScreen extends StatefulWidget {
  const BeautyOutilsScreen({super.key});

  @override
  State<BeautyOutilsScreen> createState() => _BeautyOutilsScreenState();
}

class _BeautyOutilsScreenState extends State<BeautyOutilsScreen> {
 Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 210, 209, 209),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('produits')
          .where('categories', isEqualTo: 'Beauté')
          .where('sousCategories', isEqualTo: 'Outils')
          .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
            if (snapshot.data!.docs.isEmpty) {
            return Text(
                "Aucun document trouvé"); // Retourne une interface ou un widget spécifique ici
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data =
                        snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleProd(
                              prodName: data['prodName'],
                              prodUrlImg: data['prodUrlImg'],
                              prodReduction: data['prodReduction'],
                              prixUnitaire: data['prixUnitaire'],
                              prodDetailles: data['prodDetailles'],
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.network(
                              data['prodUrlImg'],
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Text(
                              "${data['prixUnitaire']} CDF",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),     
              ),
            ],
          );
        },
      ),
    );
  }
}
