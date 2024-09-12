import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/showShopDialog.dart';
 
class AddProdSection extends StatefulWidget {
  const AddProdSection({super.key});

  @override
  State<AddProdSection> createState() => _AddProdSectionState();
}

class _AddProdSectionState extends State<AddProdSection> {
   Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: TextButton(
            onPressed: () {
                ShopDialog(user: FirebaseAuth.instance.currentUser)
                    .showProdDialog(context, ImageSource.gallery);
              },
            child: const Text('Ajouter un produit', style: TextStyle(color: Colors.black),),
          ),
        ),
      ],
    );
  }
   
}
