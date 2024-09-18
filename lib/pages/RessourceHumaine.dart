import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RessourceHumaine extends StatefulWidget {
  const RessourceHumaine({super.key});

  @override
  State<RessourceHumaine> createState() => _RessourceHumaineState();
}

class _RessourceHumaineState extends State<RessourceHumaine> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  String _selectedFunction = 'magasinier';

  final List<String> _functions = ['magasinier', 'livreur'];

  Future<void> _addAgent() async {
    if (_nameController.text.isNotEmpty) {
      await _firestore.collection('Agents').add({
        'name': _nameController.text,
        'function': _selectedFunction,
      });
      _nameController.clear();
      setState(() {
        _selectedFunction = 'magasinier';
      });
    }
  }

  Future<void> _updateAgent(String docId, String newName, String newFunction) async {
    await _firestore.collection('Agents').doc(docId).update({
      'name': newName,
      'function': newFunction,
    });
  }

  Future<void> _deleteAgent(String docId) async {
    await _firestore.collection('Agents').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajouter un nouvel agent :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom complet',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedFunction,
              items: _functions.map((function) {
                return DropdownMenuItem<String>(
                  value: function,
                  child: Text(function),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedFunction = value;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Fonction',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addAgent,
              child: const Text('Ajouter Agent'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Liste des agents :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Agents').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  }
                  final agents = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: agents.length,
                    itemBuilder: (context, index) {
                      final agent = agents[index];
                      final name = agent['name'] ?? '';
                      final function = agent['function'] ?? '';
                      final docId = agent.id;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text('Fonction : $function'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  final newName = await _showEditDialog(context, name, 'Nom complet');
                                  final newFunction = await _showEditDialog(context, function, 'Fonction');
                                  if (newName != null && newFunction != null) {
                                    await _updateAgent(docId, newName, newFunction);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await _deleteAgent(docId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showEditDialog(BuildContext context, String initialValue, String field) {
    final TextEditingController controller = TextEditingController(text: initialValue);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: field,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class RessourceHumaine extends StatefulWidget {
//   const RessourceHumaine({super.key});

//   @override
//   State<RessourceHumaine> createState() => _RessourceHumaineState();
// }

// class _RessourceHumaineState extends State<RessourceHumaine> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _nameController = TextEditingController();
//   String? _selectedFunction;
//   final List<String> _functions = ['magasinier', 'livreur'];

//   Future<void> _addAgent() async {
//     if (_nameController.text.isNotEmpty && _selectedFunction != null) {
//       await _firestore.collection('Agents').add({
//         'name': _nameController.text,
//         'function': _selectedFunction,
//       });
//       _nameController.clear();
//       setState(() {
//         _selectedFunction = null;
//       });
//     }
//   }

//   Future<void> _updateAgent(String docId, String newName, String newFunction) async {
//     await _firestore.collection('Agents').doc(docId).update({
//       'name': newName,
//       'function': newFunction,
//     });
//   }

//   Future<void> _deleteAgent(String docId) async {
//     await _firestore.collection('Agents').doc(docId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ressources Humaines'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Ajouter un nouvel agent :',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Nom complet',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               value: _selectedFunction,
//               hint: const Text('Choisir la fonction'),
//               items: _functions.map((function) {
//                 return DropdownMenuItem(
//                   value: function,
//                   child: Text(function),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedFunction = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _addAgent,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//               ),
//               child: const Text('Ajouter Agent'),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Liste des agents :',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore.collection('Agents').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Erreur : ${snapshot.error}'));
//                   }
//                   final agents = snapshot.data?.docs ?? [];
//                   return ListView.builder(
//                     itemCount: agents.length,
//                     itemBuilder: (context, index) {
//                       final agent = agents[index];
//                       final name = agent['name'] ?? '';
//                       final function = agent['function'] ?? '';
//                       final docId = agent.id;

//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 8.0),
//                         elevation: 4,
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(16.0),
//                           title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                           subtitle: Text('Fonction : $function'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.edit, color: Colors.teal),
//                                 onPressed: () async {
//                                   final newName = await _showEditDialog(context, name, 'Nom complet');
//                                   final newFunction = await _showEditDialog(context, function, 'Fonction');
//                                   if (newName != null && newFunction != null) {
//                                     await _updateAgent(docId, newName, newFunction);
//                                   }
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () async {
//                                   await _deleteAgent(docId);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String?> _showEditDialog(BuildContext context, String initialValue, String labelText) {
//     final TextEditingController controller = TextEditingController(text: initialValue);
//     return showDialog<String>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Modifier $labelText'),
//           content: TextField(
//             controller: controller,
//             decoration: InputDecoration(labelText: labelText),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(null),
//               child: const Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(controller.text),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
