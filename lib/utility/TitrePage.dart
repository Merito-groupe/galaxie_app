import 'package:flutter/material.dart';

class TitrePlusVendu extends StatelessWidget {
  const TitrePlusVendu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Plus vendus', 
          style: 
          TextStyle( 
            fontWeight: FontWeight.w900,
             color: Colors.black87,
             fontSize: 23,
             
             ),
          ),
        ),
      ],
    );
  }
}
