

import 'package:cloud_firestore/cloud_firestore.dart';

class Shop { 
  String? shopID, shopName, adressPhysique,mail, phoneNumber, shopUrlImg, shopUserID, shopUserName;
  Timestamp? shopTimestamp;
  

  Shop( 
    { 
      this.shopID,
      this.shopName,
      this.shopUrlImg,
      this.adressPhysique,
      this.mail,
      this.phoneNumber,
      this.shopUserID,
      this.shopUserName,
      this.shopTimestamp

    }
  );
}