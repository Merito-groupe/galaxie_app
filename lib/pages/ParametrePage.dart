import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxie_app/pages/Administration.dart';
import 'package:galaxie_app/pages/ChattezAvecNousPage.dart';
import 'package:galaxie_app/pages/FAQPage.dart';
import 'package:galaxie_app/pages/Parametre/ProfilUser.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildListTile(
            context,
            icon: Icons.person,
            title: 'Mon Profil',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilUser()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.folder,
            title: 'Mes Pièces',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.attach_money,
            title: 'Mon Gain',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.chat,
            title: 'Chattez avec Nous',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.help_outline,
            title: 'FAQ',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.help_outline,
            title: 'Administration',
            onTap: () async {
              await _checkAdminAccess(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFD78914)),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  Future<void> _checkAdminAccess(BuildContext context) async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userEmail = user.email ?? '';
      String userId = user.uid;

      // Check Firestore collection "admin" for matching email and userId
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: userEmail)
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // User has access, navigate to Administration page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Administration()),
        );
      } else {
        // User does not have access, show alert
        _showAccessDeniedAlert(context);
      }
    }
  }

  void _showAccessDeniedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Accès refusé'),
          content: Text('Vous n\'avez pas accès ici.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
