import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Paramettre/chattez_avec_nous_page.dart';
import 'package:galaxie_app/pages/Paramettre/faq_page.dart';
import 'package:galaxie_app/pages/Paramettre/mes_pieces_page.dart';
import 'package:galaxie_app/pages/Paramettre/mon_gain_page.dart';
import 'package:galaxie_app/pages/Paramettre/mon_profil_page.dart';
  

class ParametrePage extends StatefulWidget {
  @override
  _ParametrePageState createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: ListView(
        children: [
          _buildListTile(
            context,
            icon: Icons.person,
            title: 'Mon Profil',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MonProfilPage()),
              );
           },
          ),
          _buildListTile(
            context,
            icon: Icons.folder,
            title: 'Mes Pièces',
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MesPiecesPage()),
              );
           },
          ),
          _buildListTile(
            context,
            icon: Icons.attach_money,
            title: 'Mon Gain',
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MonGainPage()),
              );
           },
          ),
          _buildListTile(
            context,
            icon: Icons.chat,
            title: 'Chattez avec Nous',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChattezAvecNousPage()),
              );
           },
          ),
          _buildListTile(
            context,
            icon: Icons.help_outline,
            title: 'FAQ',
           onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
           },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ParametrePage extends StatefulWidget {
//   @override
//   _ParametrePageState createState() => _ParametrePageState();
// }

// class _ParametrePageState extends State<ParametrePage> {
//   final _formKey = GlobalKey<FormState>();
//   String _city = '';
//   String _routes = '';
//   String _startTime = '';
//   String _endTime = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Driver Settings'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'City',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the city';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _city = value!,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Routes',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the routes';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _routes = value!,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Start Time',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the start time';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _startTime = value!,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'End Time',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the end time';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _endTime = value!,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: Text('Save Settings'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.blue,
//                   textStyle: TextStyle(fontSize: 16),
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       try {
//         // Enregistrement dans Firestore
//         await FirebaseFirestore.instance.collection('settings').doc('driver_settings').set({
//           'city': _city,
//           'routes': _routes,
//           'startTime': _startTime,
//           'endTime': _endTime,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Settings saved successfully')),
//         );
//       } catch (e) {
//         print('Error saving settings: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error saving settings: $e')),
//         );
//       }
//     }
//   }
// }
