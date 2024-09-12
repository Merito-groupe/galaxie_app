import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/model/shop.dart';
import 'package:galaxie_app/pages/Boutiques/ProfilShopViews.dart';
import 'package:galaxie_app/utility/showSnackBar.dart';
 

class ShopDialog {
  User? user;
  ShopDialog({this.user});

  void showShopDialog(BuildContext context, ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    final _keyForm = GlobalKey<FormState>();
    String _shopName = '';
    String _adressPhysique = '';
    String _mail = '';
    String _phoneNumber = '';
    String _formError = 'Veuillez fournir les informations correctement';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final mobilHeight = MediaQuery.of(context).size.height * 0.25;
        final webHeight = MediaQuery.of(context).size.height * 0.5;

        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              height: kIsWeb ? webHeight : mobilHeight,
              margin: EdgeInsets.all(8.0),
              color: Colors.grey,
              child: kIsWeb
                  ? Image(
                      image: NetworkImage(_file.path),
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: FileImage(_file),
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _shopName = value,
                          validator: (value) =>
                              _shopName == '' ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Nom de la boutique',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _adressPhysique = value,
                          validator: (value) =>
                              _adressPhysique == '' ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Adress physique',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _mail = value,
                          validator: (value) => _mail == '' ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'Adress Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _phoneNumber = value,
                          validator: (value) =>
                              _phoneNumber == '' ? _formError : null,
                          decoration: InputDecoration(
                            labelText: 'N° Télephone',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ANNULER'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => onSubmit(
                              context,
                              _keyForm,
                              _file,
                              _pickedFile,
                              _shopName,
                              _adressPhysique,
                              _mail,
                              _phoneNumber,
                              user),
                          child: Text('PUBLIER'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void onSubmit(context, keyForm, file, fileweb, shopName,
      adressPhysique, mail, phoneNumber, user) async {
    if (keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, 'Création de boutique $shopName');

      try {
        DatabaseService db = DatabaseService();
        String _shopUrlImg = await db.uploadFile(file, fileweb);
        db.addShop(
          Shop(
              shopName: shopName,
              shopUrlImg: _shopUrlImg,
              adressPhysique: adressPhysique,
              mail: mail,
              phoneNumber: phoneNumber,
              shopUserID: user!.uid,
              shopUserName: user!.displayName, imagePath: '', about: '', shopID: ''),
        );
      } catch (error) {
        showNotification(context, "Erreur $error");
      }
    }
  }
}
