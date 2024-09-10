
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/utils/firebase_storage_service.dart';
import 'package:galaxie_app/utils/firestore_service.dart';
 
class AddAdvertisementPage extends StatefulWidget {
  @override
  _AddAdvertisementPageState createState() => _AddAdvertisementPageState();
}

class _AddAdvertisementPageState extends State<AddAdvertisementPage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  String _title = '';
  String _advertiserName = '';
  String _city = '';
  List<String> _routes = [];
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(hours: 1));
  String? _audioFilePath;
  File? _audioFile;
  int _numberOfVehicles = 0;
  bool _isLoading = false; // Variable pour suivre l'état de chargement

  final Map<String, List<String>> cityRoutes = {
    'Goma': ['transville', 'ulpgl-biréré', 'ulpgl-katoyi'],
    'Kinshasa': ['ngaba-campus', 'mitendi-upn', 'tous-kin'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Advertisement'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Title',
                    onSaved: (value) => _title = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildTextField(
                    label: 'Advertiser Name',
                    onSaved: (value) => _advertiserName = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter advertiser name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildCityDropdown(),
                  SizedBox(height: 16.0),
                  if (_city.isNotEmpty) _buildRoutesSelection(),
                  SizedBox(height: 16.0),
                  _buildTextField(
                    label: 'Number of Vehicles',
                    onSaved: (value) =>
                        _numberOfVehicles = int.tryParse(value!) ?? 0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of vehicles';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateTimeField(
                          label: 'Start Time',
                          selectedDate: _startTime,
                          onDateSelected: (date) =>
                              setState(() => _startTime = date),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: _buildDateTimeField(
                          label: 'End Time',
                          selectedDate: _endTime,
                          onDateSelected: (date) =>
                              setState(() => _endTime = date),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _pickAudioFile,
                    child: Text('Pick Audio File'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (_audioFilePath != null)
                    Text(
                      'Selected file: ${_audioFilePath!.split('/').last}',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit, // Désactiver le bouton pendant le chargement
                    child: Text('Add Advertisement'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Afficher le loader pendant le chargement
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String?) onSaved,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(),
      ),
      value: _city.isNotEmpty ? _city : null,
      items: cityRoutes.keys.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _city = newValue!;
          _routes.clear();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a city';
        }
        return null;
      },
    );
  }

  Widget _buildRoutesSelection() {
    List<String> availableRoutes = cityRoutes[_city]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Routes',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ...availableRoutes.map((route) {
          return CheckboxListTile(
            title: Text(route),
            value: _routes.contains(route),
            onChanged: (isSelected) {
              setState(() {
                if (isSelected!) {
                  _routes.add(route);
                } else {
                  _routes.remove(route);
                }
              });
            },
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required DateTime selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      controller: TextEditingController(
        text: selectedDate.toLocal().toString(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          onDateSelected(pickedDate);
        }
      },
    );
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _audioFilePath = result.files.single.path;
        _audioFile = File(_audioFilePath!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No audio file selected')),
      );
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true; // Début du chargement
      });

      try {
        if (_audioFile != null) {
          String downloadUrl = await FirebaseStorageService.uploadFile(
              _audioFile!, _audioFilePath!.split('/').last);

          await _firestoreService.addAdvertisement(
            _title,
            _advertiserName,
            downloadUrl,
            _city,
            _routes.join(', '),
            _startTime,
            _endTime,
            _numberOfVehicles,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Advertisement added successfully!')),
          );

          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select an audio file')),
          );
        }
      } catch (e) {
        print('Error adding advertisement: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding advertisement')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Fin du chargement
        });
      }
    }
  }
}








// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:tamtam_admin/utils/firebase_storage_service.dart';
// import 'package:tamtam_admin/utils/firestore_service.dart';

// class AddAdvertisementPage extends StatefulWidget {
//   @override
//   _AddAdvertisementPageState createState() => _AddAdvertisementPageState();
// }

// class _AddAdvertisementPageState extends State<AddAdvertisementPage> {
//   final _formKey = GlobalKey<FormState>();
//   final FirestoreService _firestoreService = FirestoreService();

//   String _title = '';
//   String _advertiserName = '';
//   String _city = '';
//   List<String> _routes = [];
//   DateTime _startTime = DateTime.now();
//   DateTime _endTime = DateTime.now().add(Duration(hours: 1));
//   String? _audioFilePath;
//   File? _audioFile;
//   int _numberOfVehicles = 0;

//   // Listes d'itinéraires disponibles selon la ville choisie
//   final Map<String, List<String>> cityRoutes = {
//     'Goma': ['transville', 'ulpgl-biréré', 'ulpgl-katoyi'],
//     'Kinshasa': ['ngaba-campus', 'mitendi-upn', 'tous-kin'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Advertisement'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTextField(
//                 label: 'Title',
//                 onSaved: (value) => _title = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 label: 'Advertiser Name',
//                 onSaved: (value) => _advertiserName = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter advertiser name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildCityDropdown(),
//               SizedBox(height: 16.0),
//               if (_city.isNotEmpty) _buildRoutesSelection(),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 label: 'Number of Vehicles',
//                 onSaved: (value) => _numberOfVehicles = int.tryParse(value!) ?? 0,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the number of vehicles';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildDateTimeField(
//                       label: 'Start Time',
//                       selectedDate: _startTime,
//                       onDateSelected: (date) => setState(() => _startTime = date),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: _buildDateTimeField(
//                       label: 'End Time',
//                       selectedDate: _endTime,
//                       onDateSelected: (date) => setState(() => _endTime = date),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: _pickAudioFile,
//                 child: Text('Pick Audio File'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               if (_audioFilePath != null)
//                 Text(
//                   'Selected file: ${_audioFilePath!.split('/').last}',
//                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: Text('Add Advertisement'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   backgroundColor: Colors.greenAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required Function(String?) onSaved,
//     String? Function(String?)? validator,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       validator: validator,
//       onSaved: onSaved,
//       keyboardType: keyboardType,
//     );
//   }

//   // Dropdown pour sélectionner la ville
//   Widget _buildCityDropdown() {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: 'City',
//         border: OutlineInputBorder(),
//       ),
//       value: _city.isNotEmpty ? _city : null,
//       items: cityRoutes.keys.map((String city) {
//         return DropdownMenuItem<String>(
//           value: city,
//           child: Text(city),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           _city = newValue!;
//           _routes.clear(); // Clear previously selected routes when city changes
//         });
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a city';
//         }
//         return null;
//       },
//     );
//   }

//   // Sélection multiple pour les itinéraires
//   Widget _buildRoutesSelection() {
//     List<String> availableRoutes = cityRoutes[_city]!;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Routes',
//           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//         ),
//         ...availableRoutes.map((route) {
//           return CheckboxListTile(
//             title: Text(route),
//             value: _routes.contains(route),
//             onChanged: (isSelected) {
//               setState(() {
//                 if (isSelected!) {
//                   _routes.add(route);
//                 } else {
//                   _routes.remove(route);
//                 }
//               });
//             },
//           );
//         }).toList(),
//       ],
//     );
//   }

//   Widget _buildDateTimeField({
//     required String label,
//     required DateTime selectedDate,
//     required Function(DateTime) onDateSelected,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       readOnly: true,
//       controller: TextEditingController(
//         text: selectedDate.toLocal().toString(),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: selectedDate,
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );

//         if (pickedDate != null && pickedDate != selectedDate) {
//           onDateSelected(pickedDate);
//         }
//       },
//     );
//   }

//   Future<void> _pickAudioFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _audioFilePath = result.files.single.path;
//         _audioFile = File(_audioFilePath!); // Mise à jour de l'objet File
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No audio file selected')),
//       );
//     }
//   }

//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       try {
//         if (_audioFile != null) {
//           String downloadUrl = await FirebaseStorageService.uploadFile(_audioFile!, _audioFilePath!.split('/').last);

//           await _firestoreService.addAdvertisement(
//             _title,
//             _advertiserName,
//             downloadUrl, // Utilisation de l'URL de téléchargement ici
//             _city,
//             _routes.join(', '), // Convertir la liste des itinéraires en chaîne
//             _startTime,
//             _endTime,
//             _numberOfVehicles, // Ajout du nombre de véhicules
//           );

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Advertisement added successfully!')),
//           );

//           Navigator.pop(context);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Please select an audio file')),
//           );
//         }
//       } catch (e) {
//         print('Error adding advertisement: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding advertisement')),
//         );
//       }
//     }
//   }
// }




// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:tamtam_admin/utils/firebase_storage_service.dart';
// import 'package:tamtam_admin/utils/firestore_service.dart';

// class AddAdvertisementPage extends StatefulWidget {
//   @override
//   _AddAdvertisementPageState createState() => _AddAdvertisementPageState();
// }

// class _AddAdvertisementPageState extends State<AddAdvertisementPage> {
//   final _formKey = GlobalKey<FormState>();
//   final FirestoreService _firestoreService = FirestoreService();

//   String _title = '';
//   String _advertiserName = '';
//   String _city = '';
//   String _routes = '';
//   DateTime _startTime = DateTime.now();
//   DateTime _endTime = DateTime.now().add(Duration(hours: 1));
//   String? _audioFilePath;
//   File? _audioFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Advertisement'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildTextField(
//                 label: 'Title',
//                 onSaved: (value) => _title = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 label: 'Advertiser Name',
//                 onSaved: (value) => _advertiserName = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter advertiser name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 label: 'City',
//                 onSaved: (value) => _city = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the city';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               _buildTextField(
//                 label: 'Routes',
//                 onSaved: (value) => _routes = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the routes';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildDateTimeField(
//                       label: 'Start Time',
//                       selectedDate: _startTime,
//                       onDateSelected: (date) => setState(() => _startTime = date),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: _buildDateTimeField(
//                       label: 'End Time',
//                       selectedDate: _endTime,
//                       onDateSelected: (date) => setState(() => _endTime = date),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: _pickAudioFile,
//                 child: Text('Pick Audio File'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               if (_audioFilePath != null)
//                 Text(
//                   'Selected file: ${_audioFilePath!.split('/').last}',
//                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: Text('Add Advertisement'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                   backgroundColor: Colors.greenAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required Function(String?) onSaved,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       validator: validator,
//       onSaved: onSaved,
//     );
//   }

//   Widget _buildDateTimeField({
//     required String label,
//     required DateTime selectedDate,
//     required Function(DateTime) onDateSelected,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       readOnly: true,
//       controller: TextEditingController(
//         text: selectedDate.toLocal().toString(),
//       ),
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: selectedDate,
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );

//         if (pickedDate != null && pickedDate != selectedDate) {
//           onDateSelected(pickedDate);
//         }
//       },
//     );
//   }

//   Future<void> _pickAudioFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _audioFilePath = result.files.single.path;
//         _audioFile = File(_audioFilePath!); // Mise à jour de l'objet File
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No audio file selected')),
//       );
//     }
//   }

//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       try {
//         if (_audioFile != null) {
//           String downloadUrl = await FirebaseStorageService.uploadFile(_audioFile!, _audioFilePath!.split('/').last);

//           await _firestoreService.addAdvertisement(
//             _title,
//             _advertiserName,
//             downloadUrl, // Utilisation de l'URL de téléchargement ici
//             _city,
//             _routes,
//             _startTime,
//             _endTime,
//           );

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Advertisement added successfully')),
//           );
//           Navigator.pop(context);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Please select an audio file')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding advertisement: $e')),
//         );
//       }
//     }
//   }
// }
