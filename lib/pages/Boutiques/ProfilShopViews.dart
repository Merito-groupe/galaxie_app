import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/model/shop.dart';

import 'package:provider/provider.dart';
  // Import your database service

class HomeShopViews extends StatefulWidget {
  final String? userID;

  const HomeShopViews({super.key, this.userID});

  @override
  State<HomeShopViews> createState() => _HomeShopViewsState();
}

class _HomeShopViewsState extends State<HomeShopViews> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    final _database = DatabaseService(); // Initialize your database service

    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: kIsWeb ? true : false,
          showTrackOnHover: kIsWeb ? true : false,
          child: StreamBuilder<QuerySnapshot>(
            stream: _database
                .getShops(), // Assuming getShops() is a method in your DatabaseService that gets the 'shops' collection
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ListTile(
                    leading: Image.network(
                        data['shopUrlImg']), // This will display the image
                    title: Text(data['shopName']),
                    subtitle: Text(data['adressPhysique']),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  get shops => null;

  Stream<QuerySnapshot> getShops() {
    return _db.collection('shops').snapshots();
  }

  void addShop(Shop shop) {}

  uploadFile(file, fileweb) {}

  uploadFileProd(file, fileweb) {}

  void addProd(product) {}
}
