import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Produits/AddProdSection.dart';
 
class ListProdSection extends StatefulWidget {
  @override
  _ListProdSectionState createState() => _ListProdSectionState();
}

class _ListProdSectionState extends State<ListProdSection> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: [
                  AddProdSection(),

                  SizedBox(height: 2),
                
                ],
              ),
            ),
            Text('E-mail de l\'utilisateur : ${user?.email ?? 'Non connecté'}'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      'produits') // Assurez-vous que 'produits' est le nom correct de votre collection
                  .where('shopUserID',
                      isEqualTo: user
                          ?.uid) // Assurez-vous que 'shopUserID' est le champ correct dans vos documents
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return ListTile(
                      leading: Image.network(
                          data['prodUrlImg']), // Affiche l'image du produit
                      title:Text(data['prodName']), // Affiche le nom du produit
                      subtitle: Text(data['prodDetailles']), // Affiche les détails du produit
                    );
                  },
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
