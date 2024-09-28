import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({super.key});

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  User? user;
  double totalPrixGeneral = 0.0;
  int nombreDocuments = 0; // Variable pour stocker le nombre total de documents

  @override
  void initState() {
    super.initState();
    // Récupérer l'utilisateur actuellement connecté
    user = FirebaseAuth.instance.currentUser;
    _recalculerTotalPrixGeneral(); // Recalculer les totaux lors de l'initialisation
    _compterDocuments(); // Compter les documents lors de l'initialisation
  }

  // Fonction pour recalculer le prix total général
  Future<void> _recalculerTotalPrixGeneral() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('paniers')
        .where('userId', isEqualTo: user!.uid)
        .get();

    final documents = snapshot.docs;
    totalPrixGeneral = calculerPrixTotal(documents);
    setState(() {}); // Mettre à jour l'état pour rafraîchir l'affichage
  }

  // Fonction pour compter le nombre total de documents
  Future<void> _compterDocuments() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('paniers')
        .where('userId', isEqualTo: user!.uid)
        .get();

    nombreDocuments = snapshot.docs.length;
    setState(() {}); // Mettre à jour l'état pour rafraîchir l'affichage
  }

  // Fonction pour calculer le prix total des articles dans le panier
  double calculerPrixTotal(List<DocumentSnapshot> documents) {
    double total = 0.0;
    for (var doc in documents) {
      final data = doc.data() as Map<String, dynamic>; // Convertir en Map
      final totalPrix = data['totalPrix']?.toDouble() ??
          0.0; // Assurez-vous que c'est un double
      total += totalPrix;
    }
    return total;
  }

  // Fonction pour valider la commande (simuler un processus de validation)
  Future<void> _validerCommande() async {
    // Ici, tu peux ajouter la logique de validation de commande, comme par exemple :
    // - Enregistrer la commande dans une autre collection Firestore
    // - Supprimer les articles du panier
    // - Etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Commande validée avec un total de $totalPrixGeneral FC')),
    );
  }

  // Fonction pour supprimer un document
  Future<void> _supprimerDocument(String docId) async {
    await FirebaseFirestore.instance.collection('paniers').doc(docId).delete();
    await _recalculerTotalPrixGeneral(); // Recalculer le total après suppression
    await _compterDocuments(); // Recompter les documents après suppression
  }

  // Fonction pour mettre à jour la quantité d'un document
  Future<void> _mettreAJourQuantite(String docId, int nouvelleQuantite) async {
    final docRef = FirebaseFirestore.instance.collection('paniers').doc(docId);
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data() as Map<String, dynamic>;

    final prixUnitaire = data['prixUnitaire']?.toDouble() ?? 0.0;
    final nouveauTotalPrix = prixUnitaire * nouvelleQuantite;

    await docRef.update({
      'quantiteDemandee': nouvelleQuantite,
      'totalPrix': nouveauTotalPrix,
    });

    await _recalculerTotalPrixGeneral(); // Recalculer le total après mise à jour
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mon Panier'),
          backgroundColor: const Color(0xFFD78914),
        ),
        body: const Center(child: Text('Utilisateur non connecté.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier ($nombreDocuments articles)'),
        backgroundColor: const Color(0xFFD78914),
      ),        backgroundColor: Color.fromARGB(64, 232, 231, 230),

      body: StreamBuilder<QuerySnapshot>(
        // Requête pour récupérer les articles dans le panier de l'utilisateur connecté
        stream: FirebaseFirestore.instance
            .collection('paniers')
            .where('userId', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Erreur lors du chargement du panier: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Votre panier est vide.'));
          }

          // Récupérer les documents du panier
          final documents = snapshot.data!.docs;

          // Calculer le prix total
          totalPrixGeneral = calculerPrixTotal(documents);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    final data =
                        doc.data() as Map<String, dynamic>; // Convertir en Map

                    final totalPrix = data['totalPrix']?.toDouble() ??
                        0.0; // Assurez-vous que c'est un double
                    final quantiteDemandee =
                        data['quantiteDemandee']?.toInt() ??
                            0; // Assurez-vous que c'est un int

                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => _supprimerDocument(doc.id),
                            backgroundColor: Colors
                                .redAccent, // Utilisation d'une nuance d'accent
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            // label: 'Supprimer',
                            borderRadius:
                                BorderRadius.circular(2), // Bordures arrondies
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20), // Marges intérieures
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              int nouvelleQuantite = quantiteDemandee + 1;
                              await _mettreAJourQuantite(
                                  doc.id, nouvelleQuantite);
                            },
                            backgroundColor: Colors
                                .teal, // Accentuation avec une nuance plus vive
                            foregroundColor: Colors.white,
                            icon: Icons.add,
                            // label: 'Augmenter',
                            borderRadius: BorderRadius.circular(2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          SlidableAction(
                            onPressed: (context) async {
                              if (quantiteDemandee > 1) {
                                int nouvelleQuantite = quantiteDemandee - 1;
                                await _mettreAJourQuantite(
                                    doc.id, nouvelleQuantite);
                              }
                            },
                            backgroundColor: Colors
                                .orangeAccent, // Accentuation plus lumineuse
                            foregroundColor: Colors.white,
                            icon: Icons.remove,
                            // label: 'Diminuer',
                            borderRadius: BorderRadius.circular(2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),

                           
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(
                          data['imageUrl'] ?? 'https://via.placeholder.com/50',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                        title: Text(data['nom'] ?? 'Nom non disponible'),
                        subtitle: Text(
                          'Prix Unitaire: ${data['prixUnitaire']} FC\nQuantité: $quantiteDemandee',
                        ),
                        trailing: Text('Total: $totalPrix FC'),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                     
                    Text(
                      'Prix total général: $totalPrixGeneral FC',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Bouton pour valider la commande
                    ElevatedButton(
                      onPressed: _validerCommande,
                      child:   Text('Valider la commande : $totalPrixGeneral FC',
                        style: TextStyle(  
                          fontSize: 16,
                          color: Colors.white,
                        fontWeight: FontWeight.w900
                        )
                       ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors
                                .orangeAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
