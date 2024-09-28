import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductManager extends StatefulWidget {
  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  File? _selectedImage;
  String? _imageUrl;
  bool _isLoading = false;

  String _selectedCategory = 'Soins de la peau';

  final List<String> categories = [
    'Soins de la peau',
    'Maquillage',
    'Soins capillaires',
    'Parfums',
    'Soins du corps',
    'Hygiène dentaire',
    'Produits solaires',
    'Soins mains et ongles',
    'Déodorants,anti-transpirants',
    'Accessoires de beauté'
  ];

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    // Upload image to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('produits/${DateTime.now().millisecondsSinceEpoch}');
    await storageRef.putFile(_selectedImage!);
    return await storageRef.getDownloadURL();
  }

  Future<void> _uploadProduct() async {
    _imageUrl = await _uploadImage(); // Get the new image URL

    // Add product to Firestore
    FirebaseFirestore.instance.collection('produits').add({
      'categorie': _selectedCategory,
      'nom': _nameController.text,
      'marque': _brandController.text,
      'prix': int.parse(_priceController.text),
      'quantite': int.parse(_quantityController.text),
      'description': _descriptionController.text,
      'imageUrl': _imageUrl,
    });
  }

  Future<void> _updateProduct(
      String productId, Map<String, dynamic> updatedFields) async {
    await FirebaseFirestore.instance
        .collection('produits')
        .doc(productId)
        .update(updatedFields);
  }

  void _showProductDialog([DocumentSnapshot? product]) {
    if (product != null) {
      _nameController.text = product['nom'];
      _brandController.text = product['marque'];
      _priceController.text = product['prix'].toString();
      _quantityController.text = product['quantite'].toString();
      _descriptionController.text = product['description'];
      _selectedCategory = product['categorie'];
      _imageUrl = product['imageUrl'];
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Catégorie'),
                    value: _selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      _selectedCategory = value!;
                    }),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nom du produit'),
                  ),
                  TextFormField(
                    controller: _brandController,
                    decoration: InputDecoration(labelText: 'Marque'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Prix'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantité'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: Center(child: Text('Choisir une image')),
                          )
                        : Image.file(_selectedImage!,
                            height: 200, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              if (product != null) {
                                // Si une nouvelle image est sélectionnée, téléchargez-la
                                if (_selectedImage != null) {
                                  _imageUrl = await _uploadImage();
                                }

                                // Préparez les champs mis à jour
                                final updatedFields = {
                                  if (_selectedCategory != product['categorie'])
                                    'categorie': _selectedCategory,
                                  if (_nameController.text != product['nom'])
                                    'nom': _nameController.text,
                                  if (_brandController.text !=
                                      product['marque'])
                                    'marque': _brandController.text,
                                  if (int.parse(_priceController.text) !=
                                      product['prix'])
                                    'prix': int.parse(_priceController.text),
                                  if (int.parse(_quantityController.text) !=
                                      product['quantite'])
                                    'quantite':
                                        int.parse(_quantityController.text),
                                  if (_descriptionController.text !=
                                      product['description'])
                                    'description': _descriptionController.text,
                                  if (_imageUrl != product['imageUrl'])
                                    'imageUrl': _imageUrl,
                                };

                                // Mettez à jour le produit
                                await _updateProduct(product.id, updatedFields);
                              } else {
                                await _uploadProduct();
                              }

                              // Afficher un message de succès
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(product != null
                                        ? 'Produit mis à jour avec succès'
                                        : 'Produit ajouté avec succès')),
                              );
                            } catch (e) {
                              // Afficher un message d'erreur en cas de problème
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Erreur: ${e.toString()}')),
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(product != null
                            ? 'Mettre à jour'
                            : 'Ajouter le produit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(DocumentSnapshot product) {
    return ListTile(
      leading: Image.network(product['imageUrl'],
          width: 50, height: 50, fit: BoxFit.cover),
      title: Text(product['nom']),
      subtitle: Text(
          'Marque: ${product['marque']} - Prix: ${product['prix']} - Quantité: ${product['quantite']}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
       
        children: [
          Container(
            decoration: BoxDecoration(
              color:  Colors.blue.withOpacity(0.1), // Fond bleu clair
              shape: BoxShape.circle, // Forme circulaire
            ),
            child: IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue, // Couleur de l'icône "edit"
              iconSize: 30.0,
              tooltip: 'Modifier',
              onPressed: () => _showProductDialog(product),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1), // Fond rouge clair
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red, // Couleur de l'icône "delete"
              iconSize: 30.0,
              tooltip: 'Supprimer',
              onPressed: () => FirebaseFirestore.instance
                  .collection('produits')
                  .doc(product.id)
                  .delete(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des produits'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('produits').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildProductItem(doc))
                .toList(),
          );
        },
      ),
      

       floatingActionButton: FloatingActionButton(
              onPressed: () => _showProductDialog(),
              backgroundColor: Color(0xFFD78914), // Couleur du bouton
              child: const Icon(Icons.add), // Icône du bouton
            ),
    );
  }
}
