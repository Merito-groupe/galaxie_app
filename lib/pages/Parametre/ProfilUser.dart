import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilUser extends StatefulWidget {
  const ProfilUser({super.key});

  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: const Color(0xFFD78914),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? const Center(
                child: Text(
                  'Aucun utilisateur connecté',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile picture
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
                  ),
                  const SizedBox(height: 16),
                  
                  // User name
                  Text(
                    user?.displayName ?? 'Nom non disponible',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // User email
                  Text(
                    user?.email ?? 'Email non disponible',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Additional Info (UID)
                  Text(
                    'ID Utilisateur: ${user?.uid}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Sign out button
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      'Déconnexion',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
