import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? prodID,
      prodName,
      prixUnitaire,
      prodReduction,
      mail,
      prodDetailles,
      prodMarque,
      statutDisponiblites,
      couleurDisponible,
      taillesDisponible,
      qteEnStock,
      categories,
      sousCategories,
      prodUrlImg,
      shopUserID,
      shopUserName;
  Timestamp? prodTimestamp;

  Product(
      {this.prodID,
      this.prodName,
      this.prodUrlImg,
      this.prixUnitaire,
      this.prodReduction,
      this.prodDetailles,
      this.shopUserID,
      this.shopUserName,
      this.prodTimestamp,
      this.qteEnStock,
      this.prodMarque,
      this.statutDisponiblites,
      this.taillesDisponible,
      this.couleurDisponible,
      this.sousCategories,
      this.categories});
}
