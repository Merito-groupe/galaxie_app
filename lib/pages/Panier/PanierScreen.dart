                          //   label: 'Supprimer',
 
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PanierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Center(child: Text("Veuillez vous connecter pour voir le panier"));
    }

    double totalPrix = 0;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Une erreur est survenue');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.data?.docs.isEmpty ?? true) {
          // Affiche le message "Ajouter un produit" si la collection est vide
          return Center(child: Text('Ajouter un produit'));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Mon Panier'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    int prixUnitaire = int.parse(data['productPrice']);
                    int quantity = data['quantity'];
                    int prixTotalProduit = prixUnitaire * quantity;

                    totalPrix += prixTotalProduit;

                    return Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              // Implémentez la logique d'archivage ici
                            },
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.favorite,
                            label: 'Favori',
                          ),
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              // Implémentez la logique d'archivage ici
                              // Par exemple, pour mettre à jour le champ 'isApproved' à true :
                              // Utilisez l'ID du document actuel
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .collection('CommandeProduit')
                                  .doc(document.id)
                                  .update({'isApproved': true}).then((_) {
                                print('Données mises à jour avec succès !');
                                // Vous pouvez également afficher un message de succès à l'utilisateur.
                              }).catchError((error) {
                                print(
                                    'Erreur lors de la mise à jour des données : $error');
                                // Gérez l'erreur ici ou affichez un message d'erreur à l'utilisateur.
                              });
                            },
                            backgroundColor: Color.fromARGB(255, 38, 44, 38),
                            foregroundColor: Colors.white,
                            icon: Icons.add,
                            label: 'Ajouter',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              // Get document ID from snapshot
                              String docId = document.id;

                              // Call deletion function
                              await supprimerDocument(userId, docId);

                              // Update UI or show a success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Produit supprimé du panier'),
                                ),
                              );
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Supprimer',
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(data['imageUrl']),
                        title: Text(data['productName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Couleur : ${data['color']}'),
                            Text('Taille : ${data['size']}'),
                            Text('Quantité : $quantity'),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('$prixUnitaire FC'),
                            Text('Total $prixTotalProduit FC'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total : $totalPrix FC',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Gérer l'action du bouton ici (passer commande, etc.)
                      print('Bouton "Valider" appuyé !');
                    },
                    child: Text('Commander'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Function to delete a document from Firestore
  Future<void> supprimerDocument(String userId, String docId) async {
    try {
      // Supprime le document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .doc(docId)
          .delete();

      // Affiche un message de succès à l'utilisateur
      print('Document supprimé avec succès !');
      // Vous pouvez également afficher ce message dans l'interface utilisateur.

      // Mettre à jour l'interface utilisateur ou afficher un message de succès (facultatif)
      // ... (déjà implémenté dans le rappel onPressed)
    } catch (e) {
      // Gère l'erreur ici
      print('Erreur lors de la suppression du document : $e');
      // Vous pouvez également afficher un message d'erreur à l'utilisateur
      // ou effectuer d'autres actions de récupération.
    }
  }

  Future<void> incrementerQuantite(
      String userId, String docId, int increment) async {
    try {
      // Incrémente la quantité du document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .doc(docId)
          .update({
        'quantity': FieldValue.increment(increment),
      });

      // Affiche un message de succès à l'utilisateur (facultatif)
      print('Quantité incrémentée avec succès !');
    } catch (e) {
      // Gère l'erreur ici
      print('Erreur lors de l\'incrémentation de la quantité : $e');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: PanierScreen(),
  ));

  Future<void> supprimerDocument(String userId, String docId) async {
    try {
      // Delete the document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('CommandeProduit')
          .doc(docId)
          .delete();

      // Update UI or show a success message (optional)
      // ... (already implemented in onPressed callback)
    } catch (e) {
      print('Erreur lors de la suppression du document: $e');
    }
  }
}
