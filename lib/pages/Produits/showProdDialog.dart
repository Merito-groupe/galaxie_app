import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/model/prodModel.dart';
import 'package:galaxie_app/pages/Boutiques/ProfilShopViews.dart';
import 'package:galaxie_app/utility/showSnackBar.dart';
 

class ShopDialog {
  User? user;
  ShopDialog({this.user});

  void showProdDialog(BuildContext context, ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    final _keyForm = GlobalKey<FormState>();
    String _prodName = '';
    String _prixUnitaire = '';
    String _prodReduction = '';
    String _prodDetailles = '';
    String _prodMarque = '';
    String _qteEnStock = '';
    // String _SousCategories = '';
    String _statutDisponiblites = 'Disponible'; // Valeur par défaut
    List<String> _statuts = [
      'Disponible',
      'Indisponible',
      'En rupture de stock'
    ]; // Liste des options
    String _couleurDisponible = 'Rouge'; // Valeur par défaut
    // Valeur par défaut
    List<String> _couleurs = [
      'Noire',
      'Rouge',
      'Bleu',
      'Vert',
      'Multiple Couleur',
      'RAS'
    ]; // Liste des options
// Liste des options
    String _taillesDisponible = 'Petit'; // Valeur par défaut
    List<String> _tailles = [
      'X',
      'Petit',
      'Moyen',
      'Grand',
      'Multi tailles',
      'Un autres tailles'
      'RAS'
      'RAS'
    ]; // Liste des options
    String _Categories = 'Beauté';
    List<String> _CategoriesList = [
      'Beauté',
      'Bijoux',
      'Chaussure',
      'Electronique',
      'Enfants',
      'Habillement',
      'Maison',
      'Montres',
      'Sacs',
      'Sport',
      'Vehicules',
      'Wedding',
    ];

    String _SousCategories = 'Soins Peau';

// Liste des sous-catégories disponibles
    List<String> _sousCategoriesCategorie = [
      '📍📍Type Beautés',
      'Yeux',
      'Visage',
      'Levre',
      'Outils',
      'Soins Peau',
      'Soins Capilaire',
      'Perruque',
      'Maquillage',
      '📍📍Type Maison',
      'Salle de bain',
      'Décoration',
      'Rangement et Organisation',
      'Textile',
      'Outils de Nettoyage',
      'Salle à Manger & Bar',
      'Autres',
      '📍📍Type d\'habillement',
      'Robes',
      'Tops et Tee Femme',
      'Combinaison et Pants',
      'African',
      'Tops et Tee Homme',
      'Pantalos Homme',
     ' Haut Homme',
     'Haut femme'
      'Autres Habits',
      '📍📍Type de Sacs',
      'Sac à main',
      'Collection',
      'Portefeuilles',
      'Sacs à dos',
      'Sacs à epaule',
      '📍📍Type  Sports',
      'Pantalons',
      'Camping & randonée',
      'Cyclisme',
      'Haut',
      'Maillots',
      'Robes',
      '📍📍Type Electronique',
      'Salle de Bain',
      'Décoration',
      'Appareils Menagers'
      'Informatique',
      'Téléphone',
      'Casques',
      'Rangement etOrganisation',
      'Textile',
      'Sac Etuis',
      'Outils de Nettoyage',
      'Salle à Manger & Bar',
      'Autres',
      '📍📍 Type Wedding',
      'Accessoire Mariage',
      'Robes de Mariée',
      'Robes de Soirée',
      'Vest Homme',
      'Veste Femme',
      '📍📍 Type Vehicules',
      'Electronique Auto',
      'Accessoire Vehicule',
      'Accessoire d\'automobiles',
      'Accessoire pour Moto',
      'Outils de Maintenances',
      'Produit de Sécurité',
      '📍📍Type de Chaussure',
      'Chaussures Nude',
      'Sandales & Tongs Femme',
      'Basket Femme',
      'Mocassins',
      'Sandales & Tongs Homme',
      'Chaussure de Ville',
      'Basket Homme',
      'Autres Chaussures Homme',
      '📍📍Type Bijoux',
      'Bague',
      'Bracelets',
      'Boucle d\'oreille',
      'Ensemble Bijoux',
      'Porte Clés',
      'Autres bijoux',
      '📍📍Type Enfants',
      'Jouet & Loisir',
      'Soins Bébé',
      'Vêtements Bébé',
      'Vêtements Enfants',
      'Chaussures Bébé',
      'Chaussures Enfants',
      '📍📍Type Montres',
      'Montres Numérique',
      'Montres Mécanique',
      'Montres à Quartz',
      'Montres de Poche',
    ];

    String _formError = 'Veuillez fournir les informations correctement';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final mobilHeight = MediaQuery.of(context).size.height * 0.30;
        final webHeight = MediaQuery.of(context).size.height * 0.7;

        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              height: kIsWeb ? webHeight : mobilHeight,
              margin: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 249, 242, 242),
              child: kIsWeb
                  ? Image(
                      image: NetworkImage(_file.path),
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: FileImage(_file),
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 20,
                          onChanged: (value) => _prodName = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Nom du Produit',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 10,
                          onChanged: (value) => _prixUnitaire = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Prix Unitaire',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 10,
                          onChanged: (value) => _prodReduction = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Reduction',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 250,
                          onChanged: (value) => _prodDetailles = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: ' Détailles du produit',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 250,
                          onChanged: (value) => _prodMarque = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Marque du produit',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          maxLength: 250,
                          onChanged: (value) => _qteEnStock = value,
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: ' Quantité en Stock',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          value: _statutDisponiblites,
                          onChanged: (String? newValue) {
                            _statutDisponiblites = newValue!;
                          },
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: ' Statut de disponibilité',
                            border: OutlineInputBorder(),
                          ),
                          items: _statuts
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          value: _couleurDisponible,
                          onChanged: (String? newValue) {
                            _couleurDisponible = newValue!;
                          },
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Couleur disponible',
                            border: OutlineInputBorder(),
                          ),
                          items: _couleurs
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Déclaration du widget DropdownButtonFormField pour les tailles disponibles
                        DropdownButtonFormField(
                          // La taille actuellement sélectionnée
                          value: _taillesDisponible,

                          // Fonction appelée lorsque l'utilisateur sélectionne une nouvelle taille
                          onChanged: (String? newValue) {
                            _taillesDisponible = newValue!;
                          },

                          // Fonction de validation pour vérifier si une taille a été sélectionnée
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,

                          // Décoration du champ de formulaire
                          decoration: InputDecoration(
                            labelText: 'Tailles disponible',
                            border: OutlineInputBorder(),
                          ),

                          // Création des éléments du menu déroulant à partir de la liste _tailles
                          items: _tailles
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                       
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          // La catégorie actuellement sélectionnée
                          value: _Categories,

                          // Fonction appelée lorsque l'utilisateur sélectionne une nouvelle catégorie
                          onChanged: (String? newValue) {
                            _Categories = newValue!;
                          },

                          // Fonction de validation pour vérifier si une catégorie a été sélectionnée
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,

                          // Décoration du champ de formulaire
                          decoration: InputDecoration(
                            labelText: 'Categories du produit',
                            border: OutlineInputBorder(),
                          ),

                          // Création des éléments du menu déroulant à partir de la liste _CategoriesList
                          items: _CategoriesList.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        // Déclaration de la valeur par défaut pour les sous-catégories
                        SizedBox(
                          height: 10,
                        ),
// Déclaration du widget DropdownButtonFormField pour les sous-catégories
                        DropdownButtonFormField(
                          // La sous-catégorie actuellement sélectionnée
                          value: _SousCategories,

                          // Fonction appelée lorsque l'utilisateur sélectionne une nouvelle sous-catégorie
                          onChanged: (String? newValue) {
                            _SousCategories = newValue!;
                          },

                          // Fonction de validation pour vérifier si une sous-catégorie a été sélectionnée
                          validator: (value) => value == null || value.isEmpty
                              ? _formError
                              : null,

                          // Décoration du champ de formulaire
                          decoration: InputDecoration(
                            labelText: 'Sous-Categories du produit',
                            border: OutlineInputBorder(),
                          ),

                          // Création des éléments du menu déroulant à partir de la liste _sousCategoriesCategorie
                          items: _sousCategoriesCategorie
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('ANNULER'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => onSubmit(
                              context,
                              _keyForm,
                              _file,
                              _pickedFile,
                              _prodName,
                              _prixUnitaire,
                              _prodReduction,
                              _prodDetailles,
                              _prodMarque,
                              _qteEnStock,
                              _statutDisponiblites,
                              _couleurDisponible,
                              _taillesDisponible,
                              _Categories,
                              _SousCategories,
                              user),
                          child: Text('PUBLIER'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void onSubmit(
      context,
      keyForm,
      file,
      fileweb,
      prodName,
      prixUnitaire,
      prodReduction,
      prodDetailles,
      prodMarque,
      qteEnStock,
      statutDisponiblites,
      couleurDisponible,
      taillesDisponible,
      categories,
      sousCategories,
      user) async {
    if (keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(
          context, 'Création de boutique $prodReduction et $prodName');

      try {
        DatabaseService db = DatabaseService();
        String _prodUrlImg = await db.uploadFileProd(file, fileweb);
        db.addProd(
          Product(
              prodName: prodName,
              prodUrlImg: _prodUrlImg,
              prixUnitaire: prixUnitaire,
              prodReduction: prodReduction,
              prodDetailles: prodDetailles,
              prodMarque: prodMarque,
              qteEnStock: qteEnStock,
              categories: categories,
              sousCategories: sousCategories,
              statutDisponiblites: statutDisponiblites,
              couleurDisponible: couleurDisponible,
              taillesDisponible: taillesDisponible,
              shopUserID: user!.uid,
              shopUserName: user!.displayName ?? 'Pas de nom d\'utilisateur'),
        );
      } catch (error) {
        showNotification(context, "Erreur $error");
      }
    }
  }
}
