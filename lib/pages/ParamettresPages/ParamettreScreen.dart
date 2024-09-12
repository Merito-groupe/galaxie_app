import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/StarterScreen.dart';
import 'package:galaxie_app/pages/Boutiques/CreatingShop.dart';
import 'package:galaxie_app/pages/onboarding/Onboarding.dart';
 
class ParamettreScreen extends StatefulWidget {
  const ParamettreScreen({Key? key}) : super(key: key);

  @override
  State<ParamettreScreen> createState() => _ParamettreScreenState();
}

class _ParamettreScreenState extends State<ParamettreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParamettreScreen'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Mon compte'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Adresse de Livraison'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Commandes'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Apropos de shopinkin'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Boutique'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyShop())),
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contactez nous'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),
          ),
          ListTile(
  leading: Icon(Icons.logout),
  title: Text('Déconnection'),
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnection'),
          content: Text('Voulez-vous vraiment vous déconnecter?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
            ),
            TextButton(
              child: Text('Oui'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => StarterScreen()));
              },
            ),
          ],
        );
      },
    );
  },
),

        ],
      ),
    );
  }
}
