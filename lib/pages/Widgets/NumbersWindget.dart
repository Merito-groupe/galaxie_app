import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumbersWindget extends StatelessWidget {
  const NumbersWindget({super.key});

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, '4.8', 'Articles'),
            buildDivider(),
            buildButton(context, '4.8', 'Suivient'),
            buildDivider(),
            buildButton(context, '44k', 'Abonnés'),
          ],
        ),
      );

  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider());

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: 2),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ));
}
