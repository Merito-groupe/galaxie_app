// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilUser extends StatefulWidget {
//   const ProfilUser({super.key});

//   @override
//   State<ProfilUser> createState() => _ProfilUserState();
// }

// class _ProfilUserState extends State<ProfilUser> {
//   User? user;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     user = FirebaseAuth.instance.currentUser;
//     _loadUserData();
//   }

//   // Charger les données existantes de l'utilisateur à partir de Firestore
//   Future<void> _loadUserData() async {
//     if (user != null) {
//       DocumentSnapshot userProfile = await FirebaseFirestore.instance
//           .collection('clientProfil')
//           .doc(user!.uid)
//           .get();

//       if (userProfile.exists) {
//         Map<String, dynamic>? data = userProfile.data() as Map<String, dynamic>?;
//         if (data != null) {
//           _phoneController.text = data['phone'] ?? '';
//           _cityController.text = data['city'] ?? '';
//           _genderController.text = data['gender'] ?? '';
//           _addressController.text = data['address'] ?? '';
//         }
//       }
//     }
//   }

//   // Sauvegarder les données dans Firestore
//   Future<void> _saveUserProfile() async {
//     if (_formKey.currentState!.validate() && user != null) {
//       await FirebaseFirestore.instance.collection('clientProfil').doc(user!.uid).set({
//         'email': user!.email,
//         'userId': user!.uid,
//         'phone': _phoneController.text,
//         'city': _cityController.text,
//         'gender': _genderController.text,
//         'address': _addressController.text,
//       }, SetOptions(merge: true));

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profil mis à jour avec succès')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               user?.email ?? 'Mon Profil',
//               style: const TextStyle(fontSize: 15),
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xFFD78914),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   user?.displayName ?? 'Nom non disponible',
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   user?.email ?? 'Email non disponible',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'ID Utilisateur: ${user?.uid}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Formulaire pour les informations supplémentaires
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Numéro de téléphone',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: const InputDecoration(
//                     labelText: 'Ville de résidence',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _genderController,
//                   decoration: const InputDecoration(
//                     labelText: 'Sexe',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: const InputDecoration(
//                     labelText: 'Adresse',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
                
//                 ElevatedButton(
//                   onPressed: _saveUserProfile,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     backgroundColor: Colors.orange,
//                   ),
//                   child: const Text(
//                     'Enregistrer les modifications',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilUser extends StatefulWidget {
  const ProfilUser({super.key});

  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _loadUserData();
  }

  // Charger les données existantes de l'utilisateur à partir de Firestore
  Future<void> _loadUserData() async {
    if (user != null) {
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('clientProfil')
          .doc(user!.uid)
          .get();

      if (userProfile.exists) {
        Map<String, dynamic>? data = userProfile.data() as Map<String, dynamic>?;
        if (data != null) {
          _fullNameController.text = data['fullName'] ?? ''; // Charger le nom complet
          _phoneController.text = data['phone'] ?? '';
          _cityController.text = data['city'] ?? '';
          _genderController.text = data['gender'] ?? '';
          _addressController.text = data['address'] ?? '';
        }
      }
    }
  }

  // Sauvegarder les données dans Firestore
  Future<void> _saveUserProfile() async {
    if (_formKey.currentState!.validate() && user != null) {
      await FirebaseFirestore.instance.collection('clientProfil').doc(user!.uid).set({
        'email': user!.email,
        'userId': user!.uid,
        'fullName': _fullNameController.text, // Enregistrer le nom complet
        'phone': _phoneController.text,
        'city': _cityController.text,
        'gender': _genderController.text,
        'address': _addressController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
            ),
            const SizedBox(width: 10),
            Text(
              user?.email ?? 'Mon Profil',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFD78914),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user?.photoURL ?? 'https://via.placeholder.com/150'),
                ),
                const SizedBox(height: 6),
                Text(
                  user?.displayName ?? 'Nom non disponible',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? 'Email non disponible',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ID Utilisateur: ${user?.uid}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),

                // Formulaire pour les informations supplémentaires
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom complet',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'Ville de résidence',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(
                    labelText: 'Sexe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: _saveUserProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Enregistrer les modifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
