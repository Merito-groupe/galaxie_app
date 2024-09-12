import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/showShopDialog.dart';
import 'package:galaxie_app/pages/Produits/AddProdSection.dart';
import 'package:galaxie_app/pages/Produits/SingleProduit.dart';
 

class ListeProdsView extends StatefulWidget {
  const ListeProdsView({super.key});

  @override
  State<ListeProdsView> createState() => _ListeProdsViewState();
}

class _ListeProdsViewState extends State<ListeProdsView> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddProdSection(),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('produits')
                  .where('shopUserID', isEqualTo: user?.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Erreur : ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Text("Aucun produit trouvé");
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // This is added to prevent scrolling conflict with SingleChildScrollView
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
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
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Color.fromARGB(255, 239, 238, 237),
                        child: ListTile(
                          leading: Stack(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2 / 2,
                                child: Image.network(
                                  data['prodUrlImg'],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 0,
                                child: Container(
                                  color:
                                      const Color(0xFFFF0909).withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "-${data['prodReduction']}%",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            data['prodName'],
                            style: const TextStyle(
                              color: Color.fromARGB(255, 14, 13, 13),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['prodDetailles'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis, // Limite l'affichage à deux lignes
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${data['prixUnitaire']} CDF",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${data['prodReduction']} CDF",
                                    style: TextStyle(
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                        color: Color.fromARGB(137, 255, 0, 0)),
                                    textAlign: TextAlign
                                        .justify, // Affiche le nom du produit
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
         
                ShopDialog(user: FirebaseAuth.instance.currentUser)
                    .showProdDialog(context, ImageSource.gallery);
      },
      child: Icon(Icons.add), // Change this with your desired icon
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
