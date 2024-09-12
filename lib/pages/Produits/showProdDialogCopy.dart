// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shopinkin/model/prodModel.dart';
// import 'package:shopinkin/services/dbServices.dart';
// import 'package:shopinkin/utility/showSnackBar.dart';

// class ShopDialog {
//   User? user;
//   ShopDialog({this.user});

//   void showProdDialog(BuildContext context, ImageSource source) async {
//     XFile? _pickedFile = await ImagePicker().pickImage(source: source);
//     File _file = File(_pickedFile!.path);
//     final _keyForm = GlobalKey<FormState>();
//     String _prodName = '';
//     String _prixUnitaire = '';
//     String _prodReduction = '';
//     String _prodDetailles = '';
//     String _prodMarque = '';
//     String _qteEnStock = '';
//     // String _SousCategories = '';
//     String _statutDisponiblites = 'Disponible'; // Valeur par défaut
//     List<String> _statuts = [
//       'Disponible',
//       'Indisponible',
//       'En rupture de stock'
//     ]; // Liste des options
//     String _couleurDisponible = 'Rouge g'; // Valeur par défaut
//     // Valeur par défaut
//     List<String> _couleurs = [
//       'N oire',
//       'Rouge g',
//       'Bleu',
//       'Vert',
//       'Multiple Couleur',
//       'RAS vd'
//     ]; // Liste des options
// // Liste des options
//     String _taillesDisponible = 'Petit'; // Valeur par défaut
//     List<String> _tailles = [
//       'X',
//       'Petit',
//       'Moyen',
//       'Grand',
//       'Multi tailles',
//       'RASv'
//     ]; // Liste des options
//     String _Categories = 'Bijoux';
//     List<String> _CategoriesList = [
//       'Beauty',
//       'Bijoux',
//       'Chaussure',
//       'Electronique',
//           'Enfants',
//       'Habillement',
//       'Maison',
//       'Montres',
//       'Sacs',
//       'Sport',
//       'Vehicules',
//       'Wedding',
//     ];
//     String _SousCategories = 'Beauty'; // Valeur par défaut

    

//     Map<String, List<String>> _sousCategoriesParCategorie = {
//       'Beauty': [
//         'Beauty Yeux',
//         'Beauty Visage',
//         'Beauty Levre',
//         'Beauty Outils',
//         'Beauty Soins Peau',
//         'Beauty Soins Capilaire',
//         'Beauty Perruque',
//         'Beauty Maquillage',
//       ],
//       // 'Montres': [
//       //   'Montres Numérique',
//       //   'Montres Mécanique',
//       //   'Montres à Quartz',
//       //   'Montres de Poche',
//       // ],
//       'Maison': [
//         'Salle de bain',
//         'Décoration',
//         'Rangement et Organisation',
//         'Textile',
//         'Outils de Nettoyage',
//         'Salle à Manger & Bar',
//         'Autres',
//       ],
//       // 'Enfants': [
//       //   'Jouet & Loisir',
//       //   'Soins Bébé',
//       //   'Vêtements Bébé',
//       //   'Vêtements Enfants',
//       //   'Chaussures Bébé',
//       //   'Chaussures Enfants',
//       // ],
//       // 'Bijoux': [
//       //   'Bague',
//       //   'Bracelets',
//       //   'Boucle d\'oreille',
//       //   'Ensemble Bijoux',
//       //   'Porte Clés',
//       //   'Autres bijous',
//       // ],
//       // 'Chaussure': [
//       //   'Chaussures Nude',
//       //   'Sandales & Tongs Femme',
//       //   'Basket Femme',
//       //   'Mocassins',
//       //   'Sandales & Tongs Homme',
//       //   'Chaussure de Ville',
//       //   'Basket Homme',
//       //   'Autres Chaussures pour Homme',
//       // ],
//       // 'Vehicules': [
//       //   'Electronique',
//       //   'Accessoire Vehicule',
//       //   'Accessoire d\'automobiles',
//       //   'Accessoire pour Moto',
//       //   'Outils de Maintenances',
//       //   'Produit de Sécurité',
//       // ],

//       // 'Wedding': [
//       //   'Accessoire Mariage',
//       //   'Robes de Mariée',
//       //   'Robes de Soirée',
//       //   'Vest Homme',
//       //   'Veste Femme',
//       // ],
//       // 'Electronique': [
//       //   'Salle de Bain',
//       //   'Décoration',
//       //   'Rangement etOrganisation',
//       //   'Textile',
//       //   'Outils de Nettoyage',
//       //   'Salle à Manger & Bar',
//       //   'Autres',
//       // ],
//       'Sport': [
//         'Pantalons',
//         'Camping & randonée',
//         'Cyclisme',
//         'Haut',
//         'Maillots',
//         'Veste Femme',
//         'Robes',
//       ],

//       // 'Habillement': [
//       //   'Robes',
//       //   'Tops et Tee Femme',
//       //   'Combinaison et Pants',
//       //   'African',
//       //   'Tops et Tee Homme',
//       //   'Pantalos Homme',
//       //   'Autres Habits',
//       // ],
//       // 'Sacs': [
//       //   'Sac à main',
//       //   'Collection',
//       //   'Portefeuilles',
//       //   'Sacs à dos',
//       //   'Sacs à epaule'
//       // ],

//       // Ajoutez d'autres catégories ici
//     };

//     String _formError = 'Veuillez fournir les informations correctement';
//    showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final mobilHeight = MediaQuery.of(context).size.height * 0.25;
//         final webHeight = MediaQuery.of(context).size.height * 0.5;

//         return SimpleDialog(
//           contentPadding: EdgeInsets.zero,
//           children: [
//             Container(
//               height: kIsWeb ? webHeight : mobilHeight,
//               margin: EdgeInsets.all(8.0),
//               color: const Color.fromARGB(255, 249, 242, 242),
//               child: kIsWeb
//                   ? Image(
//                       image: NetworkImage(_file.path),
//                       fit: BoxFit.cover,
//                     )
//                   : Image(
//                       image: FileImage(_file),
//                       fit: BoxFit.cover,
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Form(
//                     key: _keyForm,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           maxLength: 20,
//                           onChanged: (value) => _prodName = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Nom du Produit',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         TextFormField(
//                           maxLength: 10,
//                           onChanged: (value) => _prixUnitaire = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Prix Unitaire',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         TextFormField(
//                           maxLength: 10,
//                           onChanged: (value) => _prodReduction = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Reduction',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         TextFormField(
//                           maxLength: 250,
//                           onChanged: (value) => _prodDetailles = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: ' Détailles du produit',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         TextFormField(
//                           maxLength: 250,
//                           onChanged: (value) => _prodMarque = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Marque du produit',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         TextFormField(
//                           maxLength: 250,
//                           onChanged: (value) => _qteEnStock = value,
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: ' Quantité en Stock',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DropdownButtonFormField(
//                           value: _statutDisponiblites,
//                           onChanged: (String? newValue) {
//                             _statutDisponiblites = newValue!;
//                           },
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: ' Statut de disponibilité',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: _statuts
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DropdownButtonFormField(
//                           value: _couleurDisponible,
//                           onChanged: (String? newValue) {
//                             _couleurDisponible = newValue!;
//                           },
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Couleur disponible',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: _couleurs
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DropdownButtonFormField(
//                           value: _taillesDisponible,
//                           onChanged: (String? newValue) {
//                             _taillesDisponible = newValue!;
//                           },
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Tailles disponible',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: _tailles
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
                         
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DropdownButtonFormField(
//                           value: _Categories,
//                           onChanged: (String? newValue) {
//                             _Categories = newValue!;
//                           },
//                           validator: (value) => value == null || value.isEmpty
//                               ? _formError
//                               : null,
//                           decoration: InputDecoration(
//                             labelText: 'Categories du produit',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: _CategoriesList.map<DropdownMenuItem<String>>(
//                               (String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DropdownButtonFormField(
//                           value: _SousCategories,
//                           onChanged: (Object? newValue) {
//                             _SousCategories = newValue as String;
//                           },
//                           validator: (value) {
//                             String? stringValue = value as String?;
//                             return stringValue == null || stringValue.isEmpty
//                                 ? _formError
//                                 : null;
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Sous Categories du produit',
//                             border: OutlineInputBorder(),
//                           ),
//                           items: _sousCategoriesParCategorie[_Categories]
//                                   ?.map<DropdownMenuItem<String>>(
//                                       (String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList() ??
//                               [],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Wrap(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(right: 8.0),
//                           child: TextButton(
//                             onPressed: () => Navigator.of(context).pop(),
//                             child: Text('ANNULER'),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => onSubmit(
//                               context,
//                               _keyForm,
//                               _file,
//                               _pickedFile,
//                               _prodName,
//                               _prixUnitaire,
//                               _prodReduction,
//                               _prodDetailles,
//                               _prodMarque,
//                               _qteEnStock,
//                               _statutDisponiblites,
//                               _couleurDisponible,
//                               _taillesDisponible,
//                               _Categories,
//                               _SousCategories,
//                               user),
//                           child: Text('PUBLIER'),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

//   void onSubmit(
//       context,
//       keyForm,
//       file,
//       fileweb,
//       prodName,
//       prixUnitaire,
//       prodReduction,
//       prodDetailles,
//       prodMarque,
//       qteEnStock,
//       Categories,
//       SousCategories,
//       statutDisponiblites,
//       couleurDisponible,
//       taillesDisponible,
//       user) async {
//     if (keyForm.currentState!.validate()) {
//       Navigator.of(context).pop();
//       showNotification(
//           context, 'Création de boutique $prodReduction et $prodName');

//       try {
//         DatabaseService db = DatabaseService();
//         String _prodUrlImg = await db.uploadFileProd(file, fileweb);
//         db.addProd(
//           Product(
//               prodName: prodName,
//               prodUrlImg: _prodUrlImg,
//               prixUnitaire: prixUnitaire,
//               prodReduction: prodReduction,
//               prodDetailles: prodDetailles,
//               prodMarque: prodMarque,
//               qteEnStock: qteEnStock,
//               Categories: Categories,
//               SousCategories: SousCategories,
//               statutDisponiblites: statutDisponiblites,
//               couleurDisponible: couleurDisponible,
//               taillesDisponible: taillesDisponible,
//               shopUserID: user!.uid,
//               shopUserName: user!.displayName ?? 'Pas de nom d\'utilisateur'),
//         );
//       } catch (error) {
//         showNotification(context, "Erreur $error");
//       }
//     }
//   }

// }

// // // import 'dart:io';

// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:shopinkin/model/prodModel.dart';
// // // import 'package:shopinkin/services/dbServices.dart';
// // // import 'package:shopinkin/utility/showSnackBar.dart';

// // // class ShopDialog {
// // //   User? user;
// // //   ShopDialog({this.user});

// // //   void showProdDialog(BuildContext context, ImageSource source) async {
// // //     XFile? _pickedFile = await ImagePicker().pickImage(source: source);
// // //     File _file = File(_pickedFile!.path);
// // //     final _keyForm = GlobalKey<FormState>();
// // //     String _prodName = '';
// // //     String _prixUnitaire = '';
// // //     String _prodReduction = '';
// // //     String _prodDetailles = '';
// // //     String _prodMarque = '';
// // //     String _qteEnStock = '';
// // //     String _statutDisponiblites = '';
// // //     String _couleurDisponible = '';
// // //     String _taillesDisponible = '';
// // //     String _formError = 'Veuillez fournir les informations correctement';

// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         final mobilHeight = MediaQuery.of(context).size.height * 0.25;
// // //         final webHeight = MediaQuery.of(context).size.height * 0.5;

// // //         return SimpleDialog(
// // //           contentPadding: EdgeInsets.zero,
// // //           children: [
// // //             Container(
// // //               height: kIsWeb ? webHeight : mobilHeight,
// // //               margin: EdgeInsets.all(8.0),
// // //               color: const Color.fromARGB(255, 249, 242, 242),
// // //               child: kIsWeb
// // //                   ? Image(
// // //                       image: NetworkImage(_file.path),
// // //                       fit: BoxFit.cover,
// // //                     )
// // //                   : Image(
// // //                       image: FileImage(_file),
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Column(
// // //                 children: [
// // //                   Form(
// // //                     key: _keyForm,
// // //                     child: Column(
// // //                       children: [
// // //                         TextFormField(
// // //                           maxLength: 20,
// // //                           onChanged: (value) => _prodName = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Nom du Produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 10,
// // //                           onChanged: (value) => _prixUnitaire = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Prix Unitaire',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 10,
// // //                           onChanged: (value) => _prodReduction = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Reduction',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _prodDetailles = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Détailles du produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _prodMarque = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Marque du produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _qteEnStock = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Quantité en Stock',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _statutDisponiblites = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Statut de disponibilité',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _couleurDisponible = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Couleur disponible',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _taillesDisponible = value,
// // //                           validator: (value) =>
// // //                               value == null || value.isEmpty ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Tailles disponible',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   Align(
// // //                     alignment: Alignment.bottomRight,
// // //                     child: Wrap(
// // //                       children: [
// // //                         Padding(
// // //                           padding: EdgeInsets.only(right: 8.0),
// // //                           child: TextButton(
// // //                             onPressed: () => Navigator.of(context).pop(),
// // //                             child: Text('ANNULER'),
// // //                           ),
// // //                         ),
// // //                         ElevatedButton(
// // //                           onPressed: () => onSubmit(
// // //                               context,
// // //                               _keyForm,
// // //                               _file,
// // //                               _pickedFile,
// // //                               _prodName,
// // //                               _prixUnitaire,
// // //                               _prodReduction,
// // //                               _prodDetailles,
// // //                               _prodMarque,
// // //                               _qteEnStock,
// // //                               _statutDisponiblites,
// // //                               _couleurDisponible,
// // //                               _taillesDisponible,
// // //                               user),
// // //                           child: Text('PUBLIER'),
// // //                         )
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             )
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void onSubmit(
// // //       context,
// // //       keyForm,
// // //       file,
// // //       fileweb,
// // //       prodName,
// // //       prixUnitaire,
// // //       prodReduction,
// // //       prodDetailles,
// // //       prodMarque,
// // //       qteEnStock,
// // //       statutDisponiblites,
// // //       couleurDisponible,
// // //       taillesDisponible,
// // //       user) async {
// // //     if (keyForm.currentState!.validate()) {
// // //       Navigator.of(context).pop();
// // //       showNotification(
// // //           context, 'Création de boutique $prodReduction et $prodName');

// // //       try {
// // //         DatabaseService db = DatabaseService();
// // //         String _prodUrlImg = await db.uploadFileProd(file, fileweb);
// // //         db.addProd(
// // //           Product(
// // //               prodName: prodName,
// // //               prodUrlImg: _prodUrlImg,
// // //               prixUnitaire: prixUnitaire,
// // //               prodReduction: prodReduction,
// // //               prodDetailles: prodDetailles,
// // //               prodMarque: prodMarque,
// // //               qteEnStock: qteEnStock,
// // //               statutDisponiblites: statutDisponiblites,
// // //               couleurDisponible: couleurDisponible,
// // //               taillesDisponible: taillesDisponible,
// // //               shopUserID: user!.uid,
// // //               shopUserName: user!.displayName ?? 'Pas de nom d\'utilisateur'),
// // //         );
// // //       } catch (error) {
// // //         showNotification(context, "Erreur $error");
// // //       }
// // //     }
// // //   }
// // // }

// // // import 'dart:io';

// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:shopinkin/model/prodModel.dart';
// // // import 'package:shopinkin/services/dbServices.dart';
// // // import 'package:shopinkin/utility/showSnackBar.dart';

// // // class ShopDialog {
// // //   User? user;
// // //   ShopDialog({this.user});

// // //   void showProdDialog(BuildContext context, ImageSource source) async {
// // //     XFile? _pickedFile = await ImagePicker().pickImage(source: source);
// // //     File _file = File(_pickedFile!.path);
// // //     final _keyForm = GlobalKey<FormState>();
// // //     String _prodName = '';
// // //     String _prixUnitaire = '';
// // //     String _prodReduction = '';
// // //     String _prodDetailles = '';
// // //     String _prodMarque = '';
// // //     String _qteEnStock = '';
// // //     String _statutDisponiblites = '';
// // //     String _couleurDisponible = '';
// // //     String _taillesDisponible = '';
// // //     String _formError = 'Veuillez fournir les informations correctement';

// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         final mobilHeight = MediaQuery.of(context).size.height * 0.25;
// // //         final webHeight = MediaQuery.of(context).size.height * 0.5;

// // //         return SimpleDialog(
// // //           contentPadding: EdgeInsets.zero,
// // //           children: [
// // //             Container(
// // //               height: kIsWeb ? webHeight : mobilHeight,
// // //               margin: EdgeInsets.all(8.0),
// // //               color: const Color.fromARGB(255, 249, 242, 242),
// // //               child: kIsWeb
// // //                   ? Image(
// // //                       image: NetworkImage(_file.path),
// // //                       fit: BoxFit.cover,
// // //                     )
// // //                   : Image(
// // //                       image: FileImage(_file),
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Column(
// // //                 children: [
// // //                   Form(
// // //                     key: _keyForm,
// // //                     child: Column(
// // //                       children: [
// // //                         TextFormField(
// // //                           maxLength: 20,
// // //                           onChanged: (value) => _prodName = value,
// // //                           validator: (value) =>
// // //                               _prodName == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Nom du Produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 10,
// // //                           onChanged: (value) => _prixUnitaire = value,
// // //                           validator: (value) =>
// // //                               _prixUnitaire == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Prix Unitaire',
// // //                             border: OutlineInputBorder(),
// // //                           ), //
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 10,
// // //                           onChanged: (value) => _prodReduction = value,
// // //                           validator: (value) =>
// // //                               _prodReduction == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Reduction',
// // //                             border: OutlineInputBorder(),
// // //                           ), //prodReduction
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _prodDetailles = value,
// // //                           validator: (value) =>
// // //                               _prodDetailles == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Détailles du produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _prodMarque = value,
// // //                           validator: (value) =>
// // //                               _prodMarque == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Marque du produit',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _qteEnStock = value,
// // //                           validator: (value) =>
// // //                               _qteEnStock == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Quantité en Stock',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _statutDisponiblites = value,
// // //                           validator: (value) =>
// // //                               _statutDisponiblites == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: ' Statut de disponibilité',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _couleurDisponible = value,
// // //                           validator: (value) =>
// // //                               _couleurDisponible == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Couleur disponible',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                         TextFormField(
// // //                           maxLength: 250,
// // //                           onChanged: (value) => _taillesDisponible = value,
// // //                           validator: (value) =>
// // //                               _taillesDisponible == '' ? _formError : null,
// // //                           decoration: InputDecoration(
// // //                             labelText: 'Tailles disponible',
// // //                             border: OutlineInputBorder(),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   Align(
// // //                     alignment: Alignment.bottomRight,
// // //                     child: Wrap(
// // //                       children: [
// // //                         Padding(
// // //                           padding: EdgeInsets.only(right: 8.0),
// // //                           child: TextButton(
// // //                             onPressed: () => Navigator.of(context).pop(),
// // //                             child: Text('ANNULER'),
// // //                           ),
// // //                         ),
// // //                         ElevatedButton(
// // //                           onPressed: () => onSubmit(
// // //                               context,
// // //                               _keyForm,
// // //                               _file,
// // //                               _pickedFile,
// // //                               _prodName,
// // //                               _prixUnitaire,
// // //                               _prodReduction,
// // //                               _prodDetailles,
// // //                               _prodMarque,
// // //                               _qteEnStock,
// // //                               _statutDisponiblites,
// // //                               _couleurDisponible,
// // //                               _taillesDisponible,
// // //                               user),
// // //                           child: Text('PUBLIER'),
// // //                         )
// // //                       ],
// // //                     ),
// // //                   )
// // //                 ],
// // //               ),
// // //             )
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void onSubmit(
// // //       context,
// // //       keyForm,
// // //       file,
// // //       fileweb,
// // //       prodName,
// // //       prixUnitaire,
// // //       prodReduction,
// // //       prodDetailles,
// // //       prodMarque,
// // //       qteEnStock,
// // //       statutDisponiblites,
// // //       couleurDisponible,
// // //       taillesDisponible,
// // //       user) async {
// // //     if (keyForm.currentState!.validate()) {
// // //       Navigator.of(context).pop();
// // //       showNotification(
// // //           context, 'Création de boutique $prodReduction et $prodName');

// // //       try {
// // //         DatabaseService db = DatabaseService();
// // //         String _prodUrlImg = await db.uploadFileProd(file, fileweb);
// // //         db.addProd(
// // //           Product(
// // //               prodName: prodName,
// // //               prodUrlImg: _prodUrlImg,
// // //               prixUnitaire: prixUnitaire,
// // //               prodReduction: prodReduction,
// // //               prodDetailles: prodDetailles,
// // //               prodMarque: prodMarque,
// // //               qteEnStock: qteEnStock,
// // //               statutDisponiblites: statutDisponiblites,
// // //               couleurDisponible: couleurDisponible,
// // //               taillesDisponible: taillesDisponible,
// // //               shopUserID: user!.uid,
// // //               shopUserName: user!.displayName),
// // //         );
// // //       } catch (error) {
// // //         showNotification(context, "Erreur $error");
// // //       }
// // //     }
// // //   }
// // // }
