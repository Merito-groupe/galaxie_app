import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommandeProduit extends StatefulWidget {
  final String userId;

  const CommandeProduit({super.key, required this.userId});

  @override
  State<CommandeProduit> createState() => _CommandeProduitState();
}

class _CommandeProduitState extends State<CommandeProduit> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('CommandeProduit')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Text("Aucune commande trouvée");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevent scrolling conflict
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;

            // Check if product exists in "produits" collection
            return FutureBuilder<Map<String, dynamic>?>(
              future: FirebaseFirestore.instance
                  .collection('produits')
                  .where('prodId', isEqualTo: data['prodId']) // Replace prodId with actual field name
                  .get()
                  .then((snapshot) {
                    if (snapshot.docs.isNotEmpty) {
                      return snapshot.docs.first.data() as Map<String, dynamic>;
                    } else {
                      return null;
                    }
                  }),
              builder: (context, productSnapshot) {
                if (productSnapshot.hasData) {
                  final prodData = productSnapshot.data!;
                  return createCommandeProduitItem(prodData);
                } else if (productSnapshot.hasError) {
                  return Text('Erreur : ${productSnapshot.error}');
                } else {
                  return const SizedBox(); // Hide if product not found in "produits"
                }
              },
            );
          },
        );
      },
    );
  }

  Widget createCommandeProduitItem(Map<String, dynamic> data) {
  return Container(
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
              color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "-${data['prodReduction']}%",
                  style: TextStyle(
                    color: Colors.white,
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
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['prodDetailles'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(
                "${data['prixUnitaire']} CDF",
                style: TextStyle(
                  color: Colors.black,
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
                  color: Colors.red,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
