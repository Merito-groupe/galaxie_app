import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxie_app/pages/Administration.dart';
import 'package:galaxie_app/pages/Apropos.dart';
import 'package:galaxie_app/pages/FAQPage.dart';
import 'package:galaxie_app/pages/Parametre/ProfilUser.dart';
import 'package:galaxie_app/pages/Parametre/adresseLivraison.dart';
import 'package:galaxie_app/pages/Parametre/politiquedeRetours.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';  

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      appBar: AppBar(
        title: Text('Mon galaxy'),
      ),
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
              // Implement functionality if necessary
            },
          ),
          _buildListTile(
            context,
            icon: Icons.language,
            title: 'Langues',
            onTap: () {
              // Implement functionality if necessary
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
                MaterialPageRoute(builder: (context) => AproposdeNous()),
              );
            },
          ),
          _buildListTile(
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
              _showAccountDeletionAlert(context);
            },
          ),
          _buildListTile(
            context,
            icon: Icons.logout,
            title: 'Déconnexion',
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
          if (_isAdmin)
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

  Future<void> _showLogoutConfirmationDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation de déconnexion'),
          content: Text('Voulez-vous vraiment vous déconnecter ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text('Déconnexion'),
              onPressed: () async {
                try {
                  await _googleSignIn.signOut(); // Déconnexion de Google
                  await _auth.signOut(); // Déconnexion de Firebase

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Déconnecté avec succès'),
                    ),
                  );

                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  _showGoogleSignInDialog(); // Afficher la boîte de dialogue pour se reconnecter
                } catch (error) {
                  print('Erreur lors de la déconnexion: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showGoogleSignInDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // L'utilisateur doit interagir avec la boîte de dialogue
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Se connecter avec un nouveau compte Google'),
          content: Text('Souhaitez-vous vous connecter à un autre compte Google ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Se reconnecter'),
              onPressed: () async {
                try {
                  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

                  if (googleUser != null) {
                    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                    final AuthCredential credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );

                    await _auth.signInWithCredential(credential); // Reconnexion avec le nouveau compte
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Connexion réussie avec un nouveau compte'),
                      ),
                    );

                    Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Connexion annulée'),
                      ),
                    );
                  }
                } catch (error) {
                  print('Erreur lors de la reconnexion: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkAdminAccess(BuildContext context) async {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Administration()),
        );
      } else {
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

  void _showAccountDeletionAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression du compte'),
          content: Text('Voulez-vous vraiment supprimer votre compte ? Cette action est irréversible.'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () async {
                try {
                  User? user = _auth.currentUser;
                  if (user != null) {
                    await user.delete(); // Supprimer le compte Firebase

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Compte supprimé avec succès'),
                      ),
                    );

                    SystemNavigator.pop(); // Quitter l'application après la suppression du compte
                  }
                } catch (error) {
                  print('Erreur lors de la suppression du compte: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
