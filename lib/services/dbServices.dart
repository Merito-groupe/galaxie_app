import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:galaxie_app/model/prodModel.dart';
import 'package:galaxie_app/model/shop.dart';
 
class DatabaseService {
  String? userID, shopID;
  DatabaseService({this.userID, this.shopID});
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _shops = FirebaseFirestore.instance.collection('shops');
  final CollectionReference _produits = FirebaseFirestore.instance.collection('produits');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, XFile fileWeb) async {
    Reference reference = _storage.ref().child('shops/${DateTime.now()}.png');
    Uint8List imageTosave = await fileWeb.readAsBytes();
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = kIsWeb
        ? reference.putData(imageTosave, metaData)
        : reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
    Future<String> uploadFileProd(File file, XFile fileWeb) async {
    Reference reference = _storage.ref().child('produits/${DateTime.now()}.png');
    Uint8List imageTosave = await fileWeb.readAsBytes();
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = kIsWeb
        ? reference.putData(imageTosave, metaData)
        : reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  
    void addShop(Shop shop){ 
    _shops.add({ 
          "shopName": shop.shopName,
          "shopUrlImg": shop.shopUrlImg,
          "adressPhysique": shop.adressPhysique,
          "mail": shop.mail,
          "shopUserID": shop.shopUserID,
          "shopUserName": shop.shopUserName,
          "shopTimestamp": FieldValue.serverTimestamp(),
          
    });
  }
  void addProd(Product product){ 
    _produits.add({ 
          "prodName": product.prodName,
           "prodUrlImg": product.prodUrlImg,
           "prixUnitaire": product.prixUnitaire,
           "prodReduction":product.prodReduction,
           "prodDetailles": product.prodDetailles,
           "prodMarque":product.prodMarque,
           "qteEnStock":product.qteEnStock,
           "statutDisponiblites":product.statutDisponiblites,
           "couleurDisponible":product.couleurDisponible,
           "taillesDisponible":product.taillesDisponible,
           "sousCategories":product.sousCategories,
           "categories":product.categories,
           "shopUserID": product.shopUserID,
           "shopUserName": product.shopUserName,
           "prodTimestamp": FieldValue.serverTimestamp(),
          
    });
  }
  
  

  Stream<QuerySnapshot> getShops() {
    return _db.collection('shops').snapshots();
  }
 
 


  Stream<List<Shop>> get shops { 
    Query queryShops =_shops.orderBy('shopTimestamp', descending: true);
    return queryShops.snapshots().map((snapshot) { 
        return snapshot.docs.map((doc) { 
            return Shop( 
                shopID: doc.id,
                adressPhysique:doc.get('adressPhysique'),
                shopUserName:doc.get('shopUserName'),
                mail:doc.get('mail'),
                shopName:doc.get('shopName'), imagePath: '', about: '', shopUserID: null, phoneNumber: null, shopUrlImg: '',
            );
        }).toList();
    });
  }
 
 Stream<List<Product>> get produits { 
    Query queryProds = _produits.orderBy('prodTimestamp', descending: true);
    return queryProds.snapshots().map((snapshot) { 
        return snapshot.docs.map((doc) { 
            return Product( 
                prodID: doc.id,
                prodName: doc.get('prodName'),
                prodUrlImg: doc.get('prodUrlImg'),
                prixUnitaire: doc.get('prixUnitaire'),
                prodReduction:doc.get('prodReduction'),
                prodDetailles: doc.get('prodDetailles'),
                prodMarque:doc.get('prodMarque'),
                qteEnStock:doc.get('qteEnStock'),
                statutDisponiblites:doc.get('statutDisponiblites'),
                couleurDisponible:doc.get('couleurDisponible'),
                taillesDisponible:doc.get('taillesDisponible'),
                sousCategories:doc.get('sousCategories'),
                categories:doc.get('categories'),
                shopUserID: doc.get('shopUserID'),
                shopUserName: doc.get('shopUserName'),
                prodTimestamp: doc.get('prodTimestamp'),
            );
        }).toList();
    });
  }

}
