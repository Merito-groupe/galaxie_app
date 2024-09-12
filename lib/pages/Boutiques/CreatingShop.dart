import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/Maboutique.dart';
import 'package:galaxie_app/pages/Boutiques/showShopDialog.dart';
 

class MyShop extends StatefulWidget {
  final int userHasShop = 1;
  const MyShop({Key? key}) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar( 
          title: Text('Ma boutique'),
        ),
        body: Column(
          children: [ 
            shopinkinLogo(),
            connectingOnShop(),
            creatingShop(),
          ],
        ),
      ),
    );
  }
   
   Widget shopinkinLogo() {
    return Container(
      padding: EdgeInsets.all(0.8),
      child: Column(
        children: [
                 
             Image.asset('assets/ShopInKin.png'),
             SizedBox( height: 23,),
             Center(child: Text('Bienvenu sur la boutique shopinkin')),

        ],
      ),
    );
  }
  Widget creatingShop() {
    return Container(
      padding: EdgeInsets.all(0.8),
      child: Column(
        children: [
           SizedBox(
            height: 23,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ShopDialog(user: FirebaseAuth.instance.currentUser)
                    .showShopDialog(context, ImageSource.gallery);
              },
              child: Text('Je crées ma boutique'),
            ),
          ),
        ],
      ),
    );
  }

Widget connectingOnShop() {
  return Container(
    padding: EdgeInsets.all(0.8),
    child: Column(
      children: [
         SizedBox(
          height: 23,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Maboutique(),
              ),
            );
          },
          child: Text('Je me connecte à la boutique'),
        ),
      ],
    ),
  );
}

  // Widget showBoutique() {
  //   if (widget.userHasShop == 1) {
  //     return connectingOnShop();
  //   } else {
  //     return creatingShop ();
  //   }
  // }
}
