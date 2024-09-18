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
  final TextEditingController _quantityController = TextEditingController();
  File? _selectedImage;
  String? _imageUrl;
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
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadProduct() async {
    if (_selectedImage == null) return;

    // Upload image to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('produits/${DateTime.now().millisecondsSinceEpoch}');
    await storageRef.putFile(_selectedImage!);
    _imageUrl = await storageRef.getDownloadURL();

    // Add product to Firestore
    FirebaseFirestore.instance.collection('produits').add({
      'categorie': _selectedCategory,
      'nom': _nameController.text,
      'marque': _brandController.text,
      'prix': int.parse(_priceController.text),
      'quantite': int.parse(_quantityController.text),
      'imageUrl': _imageUrl,
    });
  }

  Future<void> _updateProduct(String productId, Map<String, dynamic> updatedFields) async {
    await FirebaseFirestore.instance.collection('produits').doc(productId).update(updatedFields);
  }

  void _showProductDialog([DocumentSnapshot? product]) {
    if (product != null) {
      _nameController.text = product['nom'];
      _brandController.text = product['marque'];
      _priceController.text = product['prix'].toString();
      _quantityController.text = product['quantite'].toString();
      _selectedCategory = product['categorie'];
      _imageUrl = product['imageUrl'];
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*50,
          height: MediaQuery.of(context).size.height,
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
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: Center(child: Text('Choisir une image')),
                          )
                        : Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (product != null) {
                        _updateProduct(product.id, {
                          if (_selectedCategory != product['categorie'])
                            'categorie': _selectedCategory,
                          if (_nameController.text != product['nom'])
                            'nom': _nameController.text,
                          if (_brandController.text != product['marque'])
                            'marque': _brandController.text,
                          if (int.parse(_priceController.text) != product['prix'])
                            'prix': int.parse(_priceController.text),
                          if (int.parse(_quantityController.text) != product['quantite'])
                            'quantite': int.parse(_quantityController.text),
                          if (_imageUrl != product['imageUrl'])
                            'imageUrl': _imageUrl,
                        });
                      } else {
                        _uploadProduct();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(product != null ? 'Mettre à jour' : 'Ajouter le produit'),
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
      leading: Image.network(product['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
      title: Text(product['nom']),
      subtitle: Text('Marque: ${product['marque']} - Prix: ${product['prix']} - Quantité: ${product['quantite']}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showProductDialog(product),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => FirebaseFirestore.instance.collection('produits').doc(product.id).delete(),
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
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildProductItem(doc)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'dart:io';

// class ProductManager extends StatefulWidget {
//   @override
//   _ProductManagerState createState() => _ProductManagerState();
// }

// class _ProductManagerState extends State<ProductManager> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _brandController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   String? _selectedCategory;
//   File? _selectedImage;
//   String? _imageUrl;

//   final categories = ['Soins de la peau', 'Maquillage', 'Soins capillaires'];

//   // Firestore and Firebase Storage References
//   final CollectionReference productsRef = FirebaseFirestore.instance.collection('produits');
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });
//     }
//   }

//   Future<void> _uploadProduct() async {
//     if (_selectedImage != null) {
//       // Upload image to Firebase Storage
//       final imageName = DateTime.now().millisecondsSinceEpoch.toString();
//       final storageRef = _storage.ref().child('produits/$imageName');
//       await storageRef.putFile(_selectedImage!);
//       _imageUrl = await storageRef.getDownloadURL();
//     }

//     // Add product to Firestore
//     await productsRef.add({
//       'categorie': _selectedCategory,
//       'imageUrl': _imageUrl,
//       'marque': _brandController.text,
//       'nom': _nameController.text,
//       'prix': int.parse(_priceController.text),
//       'quantite': int.parse(_quantityController.text),
//     });

//     // Clear input fields
//     _nameController.clear();
//     _brandController.clear();
//     _priceController.clear();
//     _quantityController.clear();
//     setState(() {
//       _selectedImage = null;
//       _selectedCategory = null;
//     });
//   }

//   Future<void> _updateProduct(String docId, Map<String, dynamic> updatedFields) async {
//     await productsRef.doc(docId).update(updatedFields);
//   }

//   Future<void> _deleteProduct(String docId) async {
//     await productsRef.doc(docId).delete();
//   }

//   void _showProductDialog({DocumentSnapshot? product}) {
//     if (product != null) {
//       // Prefill dialog with product info for editing
//       _nameController.text = product['nom'];
//       _brandController.text = product['marque'];
//       _priceController.text = product['prix'].toString();
//       _quantityController.text = product['quantite'].toString();
//       _selectedCategory = product['categorie'];
//       _imageUrl = product['imageUrl'];
//     }

//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: 'Catégorie'),
//                   value: _selectedCategory,
//                   items: categories.map((category) {
//                     return DropdownMenuItem(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) => setState(() {
//                     _selectedCategory = value!;
//                   }),
//                 ),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Nom du produit'),
//                 ),
//                 TextFormField(
//                   controller: _brandController,
//                   decoration: InputDecoration(labelText: 'Marque'),
//                 ),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: InputDecoration(labelText: 'Prix'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextFormField(
//                   controller: _quantityController,
//                   decoration: InputDecoration(labelText: 'Quantité'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 16),
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: _selectedImage == null
//                       ? Container(
//                           height: 200,
//                           color: Colors.grey[300],
//                           child: Center(child: Text('Choisir une image')),
//                         )
//                       : Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (product != null) {
//                       // Update product
//                       _updateProduct(product.id, {
//                         if (_selectedCategory != product['categorie']) 'categorie': _selectedCategory,
//                         if (_nameController.text != product['nom']) 'nom': _nameController.text,
//                         if (_brandController.text != product['marque']) 'marque': _brandController.text,
//                         if (int.parse(_priceController.text) != product['prix']) 'prix': int.parse(_priceController.text),
//                         if (int.parse(_quantityController.text) != product['quantite']) 'quantite': int.parse(_quantityController.text),
//                         if (_imageUrl != product['imageUrl']) 'imageUrl': _imageUrl,
//                       });
//                     } else {
//                       _uploadProduct();
//                     }
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(product != null ? 'Mettre à jour' : 'Ajouter le produit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Gestion des produits')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: productsRef.snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return CircularProgressIndicator();
//           return ListView(
//             children: snapshot.data!.docs.map((doc) {
//               return Slidable(
//                 startActionPane: ActionPane(
//                   motion: const DrawerMotion(),
//                   children: [
//                     SlidableAction(
//                       onPressed: (context) => _showProductDialog(product: doc),
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       icon: Icons.edit,
//                       label: 'Modifier',
//                     ),
//                   ],
//                 ),
//                 endActionPane: ActionPane(
//                   motion: const DrawerMotion(),
//                   children: [
//                     SlidableAction(
//                       onPressed: (context) => _deleteProduct(doc.id),
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       icon: Icons.delete,
//                       label: 'Supprimer',
//                     ),
//                   ],
//                 ),
//                 child: ListTile(
//                   leading: Image.network(doc['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
//                   title: Text(doc['nom']),
//                   subtitle: Text('Prix: ${doc['prix']} | Quantité: ${doc['quantite']}'),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showProductDialog(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'dart:io';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProductScreen(),
//     );
//   }
// }

// class ProductScreen extends StatefulWidget {
//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final _picker = ImagePicker();
//   File? _imageFile;
//   String _selectedCategory = 'Soins capillaires';
//   String _name = '';
//   String _brand = '';
//   double _price = 0;
//   int _quantity = 0;
//   bool _isLoading = false;

//   final _categories = [
//     'Soins de la peau',
//     'Maquillage',
//     'Soins capillaires',
//     'Parfums et eaux de toilette',
//     'Soins du corps',
//     'Hygiène bucco-dentaire',
//     'Produits solaires',
//     'Soins des mains et des ongles',
//     'Déodorants et anti-transpirants',
//     'Accessoires de beauté'
//   ];

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadProduct() async {
//     if (_imageFile == null || _name.isEmpty || _brand.isEmpty || _price <= 0 || _quantity <= 0) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('products')
//           .child(DateTime.now().toString() + '.jpg');
//       await ref.putFile(_imageFile!);
//       final imageUrl = await ref.getDownloadURL();

//       await FirebaseFirestore.instance.collection('produits').add({
//         'categorie': _selectedCategory,
//         'imageUrl': imageUrl,
//         'marque': _brand,
//         'nom': _name,
//         'prix': _price,
//         'quantite': _quantity,
//       });

//       setState(() {
//         _imageFile = null;
//         _name = '';
//         _brand = '';
//         _price = 0;
//         _quantity = 0;
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle error
//     }
//   }

//   Future<void> _deleteProduct(String docId) async {
//     try {
//       await FirebaseFirestore.instance.collection('produits').doc(docId).delete();
//     } catch (error) {
//       // Handle error
//     }
//   }

//   Future<void> _updateProduct(String docId, Map<String, dynamic> data) async {
//     try {
//       await FirebaseFirestore.instance.collection('produits').doc(docId).update(data);
//     } catch (error) {
//       // Handle error
//     }
//   }

//   Future<void> _showProductDialog(BuildContext context, String docId, Map<String, dynamic> product) async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Modifier le produit'),
//           content: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: SingleChildScrollView(
//               child: _buildProductForm(product, docId),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _updateProduct(docId, {
//                   'categorie': _selectedCategory,
//                   'imageUrl': _imageFile != null ? _imageFile!.path : product['imageUrl'],
//                   'marque': _brand,
//                   'nom': _name,
//                   'prix': _price,
//                   'quantite': _quantity,
//                 });
//               },
//               child: Text('Sauvegarder'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Gestion des Produits')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('produits').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData) {
//                   return Center(child: Text('Aucun produit trouvé.'));
//                 }

//                 final products = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index].data() as Map<String, dynamic>;
//                     final docId = products[index].id;

//                     return Slidable(
//                       child: ListTile(
//                         leading: Container(
//                           width: 50,
//                           height: 50,
//                           child: Image.network(
//                             product['imageUrl'],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) => Container(
//                               color: Colors.grey[300],
//                               child: Icon(Icons.error, color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         title: Text(product['nom']),
//                         subtitle: Text('${product['marque']} - ${product['prix']}€'),
//                         trailing: Text('Quantité: ${product['quantite']}'),
//                       ),
//                       endActionPane: ActionPane(
//                         motion: ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             onPressed: (context) => _showProductDialog(context, docId, product),
//                             backgroundColor: Colors.blue,
//                             foregroundColor: Colors.white,
//                             icon: Icons.edit,
//                             label: 'Modifier',
//                           ),
//                           SlidableAction(
//                             onPressed: (context) => _deleteProduct(docId),
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete,
//                             label: 'Supprimer',
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Ajouter un produit'),
//                       content: SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               GestureDetector(
//                                 onTap: _pickImage,
//                                 child: _imageFile != null
//                                     ? Container(
//                                         width: 100,
//                                         height: 100,
//                                         child: Image.file(
//                                           _imageFile!,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )
//                                     : Container(
//                                         width: 100,
//                                         height: 100,
//                                         color: Colors.grey[300],
//                                         child: Icon(
//                                           Icons.add_a_photo,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(labelText: 'Nom'),
//                                 onChanged: (value) => setState(() => _name = value),
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(labelText: 'Marque'),
//                                 onChanged: (value) => setState(() => _brand = value),
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(labelText: 'Prix'),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (value) => setState(() => _price = double.parse(value)),
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(labelText: 'Quantité'),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (value) => setState(() => _quantity = int.parse(value)),
//                               ),
//                               DropdownButton<String>(
//                                 value: _selectedCategory,
//                                 items: _categories.map((category) {
//                                   return DropdownMenuItem<String>(
//                                     value: category,
//                                     child: Text(category),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) => setState(() => _selectedCategory = value!),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('Annuler'),
//                         ),
//                         SizedBox(width: 8),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             _uploadProduct();
//                           },
//                           child: Text('Ajouter'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: _isLoading ? CircularProgressIndicator() : Text('Ajouter un produit'),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImage,
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }

//   Widget _buildProductForm(Map<String, dynamic> product, String docId) {
//     TextEditingController nameController = TextEditingController(text: product['nom']);
//     TextEditingController brandController = TextEditingController(text: product['marque']);
//     TextEditingController priceController = TextEditingController(text: product['prix'].toString());
//     TextEditingController quantityController = TextEditingController(text: product['quantite'].toString());

//     return Column(
//       children: [
//         GestureDetector(
//           onTap: _pickImage,
//           child: _imageFile != null
//               ? Container(
//                   width: 100,
//                   height: 100,
//                   child: Image.file(
//                     _imageFile!,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               : Container(
//                   width: 100,
//                   height: 100,
//                   color: Colors.grey[300],
//                   child: Icon(
//                     Icons.add_a_photo,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//         ),
//         TextField(
//           controller: nameController,
//           decoration: InputDecoration(labelText: 'Nom'),
//           onChanged: (value) => _name = value,
//         ),
//         TextField(
//           controller: brandController,
//           decoration: InputDecoration(labelText: 'Marque'),
//           onChanged: (value) => _brand = value,
//         ),
//         TextField(
//           controller: priceController,
//           decoration: InputDecoration(labelText: 'Prix'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) => _price = double.tryParse(value) ?? 0,
//         ),
//         TextField(
//           controller: quantityController,
//           decoration: InputDecoration(labelText: 'Quantité'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) => _quantity = int.tryParse(value) ?? 0,
//         ),
//         DropdownButton<String>(
//           value: _selectedCategory,
//           items: _categories.map((category) {
//             return DropdownMenuItem<String>(
//               value: category,
//               child: Text(category),
//             );
//           }).toList(),
//           onChanged: (value) => _selectedCategory = value!,
//         ),
//       ],
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'dart:io';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProductScreen(),
//     );
//   }
// }

// class ProductScreen extends StatefulWidget {
//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final _picker = ImagePicker();
//   File? _imageFile;
//   String _selectedCategory = 'Soins capillaires';
//   String _name = '';
//   String _brand = '';
//   double _price = 0;
//   int _quantity = 0;
//   bool _isLoading = false;

//   final _categories = [
//     'Soins de la peau',
//     'Maquillage',
//     'Soins capillaires',
//     'Parfums et eaux de toilette',
//     'Soins du corps',
//     'Hygiène bucco-dentaire',
//     'Produits solaires',
//     'Soins des mains et des ongles',
//     'Déodorants et anti-transpirants',
//     'Accessoires de beauté'
//   ];

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadProduct() async {
//     if (_imageFile == null || _name.isEmpty || _brand.isEmpty || _price <= 0 || _quantity <= 0) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('products')
//           .child(DateTime.now().toString() + '.jpg');
//       await ref.putFile(_imageFile!);
//       final imageUrl = await ref.getDownloadURL();

//       await FirebaseFirestore.instance.collection('produits').add({
//         'categorie': _selectedCategory,
//         'imageUrl': imageUrl,
//         'marque': _brand,
//         'nom': _name,
//         'prix': _price,
//         'quantite': _quantity,
//       });

//       setState(() {
//         _imageFile = null;
//         _name = '';
//         _brand = '';
//         _price = 0;
//         _quantity = 0;
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle error
//     }
//   }

//   Future<void> _deleteProduct(String docId) async {
//     try {
//       await FirebaseFirestore.instance.collection('produits').doc(docId).delete();
//     } catch (error) {
//       // Handle error
//     }
//   }

//   Future<void> _updateProduct(String docId, Map<String, dynamic> data) async {
//     try {
//       await FirebaseFirestore.instance.collection('produits').doc(docId).update(data);
//     } catch (error) {
//       // Handle error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Gestion des Produits')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('produits').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData) {
//                   return Center(child: Text('Aucun produit trouvé.'));
//                 }

//                 final products = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index].data() as Map<String, dynamic>;
//                     final docId = products[index].id;

//                     return Slidable(
//                       child: ListTile(
//                         leading: Container(
//                           width: 50,
//                           height: 50,
//                           child: Image.network(
//                             product['imageUrl'],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) => Container(
//                               color: Colors.grey[300],
//                               child: Icon(Icons.error, color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         title: Text(product['nom']),
//                         subtitle: Text('${product['marque']} - ${product['prix']}€'),
//                         trailing: Text('Quantité: ${product['quantite']}'),
//                       ),
//                       endActionPane: ActionPane(
//                         motion: ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             onPressed: (context) => showDialog(
//                               context: context,
//                               builder: (context) => Dialog(
//                                 child: LayoutBuilder(
//                                   builder: (context, constraints) {
//                                     return Container(
//                                       width: constraints.maxWidth * 1.8,
//                                       height: constraints.maxHeight, // Ajuster la hauteur du Dialog
//                                       padding: EdgeInsets.all(6.0),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Modifier le produit',
//                                             style: Theme.of(context).textTheme.headline6,
//                                           ),
//                                           Expanded(
//                                             child: SingleChildScrollView(
//                                               child: _buildProductForm(product, docId),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             backgroundColor: Colors.blue,
//                             foregroundColor: Colors.white,
//                             icon: Icons.edit,
//                             label: 'Modifier',
//                           ),
//                           SlidableAction(
//                             onPressed: (context) => _deleteProduct(docId), 
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete,
//                             label: 'Supprimer',
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await showDialog(
//                   context: context,
//                   builder: (context) => Dialog(
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         return Container(
//                           width: constraints.maxWidth * 2.8,
//                           height: constraints.maxHeight,  
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Ajouter un produit',
//                                 style: Theme.of(context).textTheme.headline6,
//                               ),
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: _pickImage,
//                                         child: _imageFile != null
//                                             ? Container(
//                                                 width: 100,
//                                                 height: 100,
//                                                 child: Image.file(
//                                                   _imageFile!,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               )
//                                             : Container(
//                                                 width: 100,
//                                                 height: 100,
//                                                 color: Colors.grey[300], // Couleur de fond pour l'image manquante
//                                                 child: Icon(
//                                                   Icons.add_a_photo,
//                                                   color: Colors.grey[600],
//                                                 ),
//                                               ),
//                                       ),
//                                       TextField(
//                                         decoration: InputDecoration(labelText: 'Nom'),
//                                         onChanged: (value) => setState(() => _name = value),
//                                       ),
//                                       TextField(
//                                         decoration: InputDecoration(labelText: 'Marque'),
//                                         onChanged: (value) => setState(() => _brand = value),
//                                       ),
//                                       TextField(
//                                         decoration: InputDecoration(labelText: 'Prix'),
//                                         keyboardType: TextInputType.number,
//                                         onChanged: (value) => setState(() => _price = double.parse(value)),
//                                       ),
//                                       TextField(
//                                         decoration: InputDecoration(labelText: 'Quantité'),
//                                         keyboardType: TextInputType.number,
//                                         onChanged: (value) => setState(() => _quantity = int.parse(value)),
//                                       ),
//                                       DropdownButton<String>(
//                                         value: _selectedCategory,
//                                         items: _categories.map((category) {
//                                           return DropdownMenuItem<String>(
//                                             value: category,
//                                             child: Text(category),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) => setState(() => _selectedCategory = value!),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('Annuler'),
//                                   ),
//                                   SizedBox(width: 8),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       _uploadProduct();
//                                     },
//                                     child: Text('Ajouter'),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//               child: _isLoading ? CircularProgressIndicator() : Text('Ajouter un produit'),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImage,
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }

//   Widget _buildProductForm(Map<String, dynamic> product, String docId) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: _pickImage,
//           child: _imageFile != null
//               ? Container(
//                   width: 200,
//                   height: 100,
//                   child: Image.file(
//                     _imageFile!,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               : Container(
//                   width: 200,
//                   height: 100,
//                   color: Colors.grey[300],
//                   child: Icon(
//                     Icons.add_a_photo,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Nom'),
//           onChanged: (value) => setState(() => _name = value),
//           controller: TextEditingController(text: product['nom']),
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Marque'),
//           onChanged: (value) => setState(() => _brand = value),
//           controller: TextEditingController(text: product['marque']),
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Prix'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) => setState(() => _price = double.parse(value)),
//           controller: TextEditingController(text: product['prix'].toString()),
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Quantité'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) => setState(() => _quantity = int.parse(value)),
//           controller: TextEditingController(text: product['quantite'].toString()),
//         ),
//         DropdownButton<String>(
//           value: _selectedCategory,
//           items: _categories.map((category) {
//             return DropdownMenuItem<String>(
//               value: category,
//               child: Text(category),
//             );
//           }).toList(),
//           onChanged: (value) => setState(() => _selectedCategory = value!),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Annuler'),
//             ),
//             SizedBox(width: 8),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _updateProduct(docId, {
//                   'categorie': _selectedCategory,
//                   'imageUrl': _imageFile != null ? _imageFile!.path : product['imageUrl'],
//                   'marque': _brand,
//                   'nom': _name,
//                   'prix': _price,
//                   'quantite': _quantity,
//                 });
//               },
//               child: Text('Sauvegarder'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


