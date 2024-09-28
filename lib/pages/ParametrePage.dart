import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxie_app/pages/Administration.dart';
import 'package:galaxie_app/pages/ChattezAvecNousPage.dart';
import 'package:galaxie_app/pages/FAQPage.dart';
import 'package:galaxie_app/pages/Parametre/ProfilUser.dart';
import 'package:galaxie_app/pages/Parametre/adresseLivraison.dart';
import 'package:galaxie_app/pages/Parametre/politiquedeRetours.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isAdmin = false; // Variable pour indiquer si l'utilisateur est admin

  @override
  void initState() {
    super.initState();
    _checkIfUserIsAdmin(); // Vérification lors de l'initialisation de la page
  }

  Future<void> _checkIfUserIsAdmin() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userEmail = user.email ?? '';
      String userId = user.uid;

      // Vérifier la collection "admin" pour cet utilisateur
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: userEmail)
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Si l'utilisateur est trouvé, mettre à jour _isAdmin à true
        setState(() {
          _isAdmin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar( 
          title: Text('Mon galaxy'),

        ) ,
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
            icon: Icons.location_on,
            title: 'Gestion d\'adresse',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdresseLivraison()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.card_giftcard,
            title: 'Mes Bonus',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              // );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.language,
            title: 'Langues',
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              // );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.policy,
            title: 'Politiques de retours',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PolitiquesdeRetour()),
              );
            },
          ),
          _buildListTile(
            context,
            icon: Icons.info,
            title: 'Apropos de Galaxie',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),_buildListTile(
            context,
            icon: Icons.help,
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
            icon: Icons.delete_forever,
            title: 'Supprimer mon compte',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),
          if (_isAdmin) // Afficher seulement si l'utilisateur est admin
            _buildListTile(
              context,
              icon: Icons.admin_panel_settings,
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
    // Vérification de l'accès admin avant de rediriger
    User? user = _auth.currentUser;

    if (user != null) {
      String userEmail = user.email ?? '';
      String userId = user.uid;

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: userEmail)
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // L'utilisateur a accès, redirection vers Administration page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   Administration()),
        );
      } else {
        // L'utilisateur n'a pas accès, afficher une alerte
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










 