 import 'package:flutter/material.dart';


 AppBar buildAppBar(BuildContext) { 
  return AppBar( 
    leading: BackButton(),
    backgroundColor: Colors.transparent, // it transforming the app bar to a transparent
    elevation: 0,
    actions: [ 
      IconButton( 
      onPressed: () {},
       icon: Icon(Icons.pause_circle_outline), 
       )
    ],
  );
 }