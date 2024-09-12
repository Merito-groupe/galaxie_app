import 'dart:convert';

import 'package:galaxie_app/model/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

 
class ShopReferences {
  static late SharedPreferences _preferences;
        static const _keyShopper = 'shop';
    static const myShop = Shop( 
        imagePath:'https://img.freepik.com/photos-gratuite/belle-fille-au-magasin-tapis-traditionnel-dans-ville-goreme-cappadoce-turquie_335224-554.jpg?t=st=1716380859~exp=1716384459~hmac=8f0332c809693fbce16df20f5397ff979fe5e1dd13fcfe43de2386706a342428&w=826',
        shopName:"BetehelShop",
        mail:"retasongloire12346@gmail.com",
        about:"La Chouette Boutique est une boutique en ligne dédiée aux femmes qui recherchent des vêtements élégants, confortables et abordables. Nous proposons une large sélection de robes, hauts, bas, accessoires et plus encore, tous soigneusement sélectionnés pour répondre à vos besoins et à votre style", shopUserName: null, adressPhysique: null, shopID: '', shopUserID: null, phoneNumber: null, shopUrlImg: '',
       
    );
    static Future init () async =>
    _preferences = await SharedPreferences.getInstance();

    static Future setShop ( Shop shop) async { 
      final json = jsonEncode(shop.toJson());
      await _preferences.setString(_keyShopper, json);
     }
     static Shop getUser() {
    final json = _preferences.getString(_keyShopper);

    return json == null ? myShop : Shop.fromJson(jsonDecode(json));
  }
}