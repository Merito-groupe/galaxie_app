import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtomWidget ({ 
    Key? key,
    required this.text,
    required this.onClicked,
  }):super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton( 
    style: ElevatedButton.styleFrom( 
      shape:StadiumBorder(), 
      backgroundColor: Colors.red,
      // onPrimary:Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: Text(text),
    onPressed: onClicked,
  );
  }
