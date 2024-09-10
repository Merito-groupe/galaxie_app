import 'package:flutter/material.dart';
import 'package:galaxie_app/utils/firestore_service.dart';
 
  
class MonProfilPage extends StatefulWidget {
  @override
  _MonProfilPageState createState() => _MonProfilPageState();
}

class _MonProfilPageState extends State<MonProfilPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _city = 'Kinshasa1'; // Par défaut, Kinshasa est sélectionné
  List<String> _routes = [];
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  String _password = '';
  String _confirmPassword = '';

  final List<String> _cities = ['Kinshasa1', 'Goma'];
  final List<String> _availableRoutes = ['ulpgl-birere', 'katoyi-birere', 'birere-mugunga', 'transville'];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ Prénom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value ?? '';
                },
              ),
              SizedBox(height: 16),

              // Champ Nom
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value ?? '';
                },
              ),
              SizedBox(height: 16),

              // Champ Ville
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Ville',
                  border: OutlineInputBorder(),
                ),
                value: _city,
                onChanged: (newValue) {
                  setState(() {
                    _city = newValue!;
                  });
                },
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Champ Itinéraires
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Itinéraires',
                  border: OutlineInputBorder(),
                ),
                child: Column(
                  children: _availableRoutes.map((route) {
                    return CheckboxListTile(
                      title: Text(route),
                      value: _routes.contains(route),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _routes.add(route);
                          } else {
                            _routes.remove(route);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),

              // Champ Heure de Départ
              ListTile(
                title: Text('Heure de début'),
                trailing: Text('${_startTime.format(context)}'),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );
                  if (picked != null && picked != _startTime) {
                    setState(() {
                      _startTime = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 16),

              // Champ Heure de Fin
              ListTile(
                title: Text('Heure de fin'),
                trailing: Text('${_endTime.format(context)}'),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );
                  if (picked != null && picked != _endTime) {
                    setState(() {
                      _endTime = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 16),

              // Champ Mot de Passe
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  } else if (value.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Champ Confirmer le Mot de Passe
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez confirmer votre mot de passe';
                  } else if (value != _password) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Bouton de Soumission
              ElevatedButton(
                onPressed: _submit,
                child: Text('Enregistrer le profil'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 16),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Debugging: Print the values to the console
      print('First Name: $_firstName');
      print('Last Name: $_lastName');

      try {
        final profileData = {
          'firstName': _firstName,
          'lastName': _lastName,
          'city': _city,
          'routes': _routes,
          'startTime': _startTime.format(context),
          'endTime': _endTime.format(context),
          'password': _password,
        };

        final firestoreService = FirestoreService();
        await firestoreService.addDriverProfile(profileData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil enregistré avec succès')),
        );
      } catch (e) {
        print('Erreur lors de l\'enregistrement du profil : $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'enregistrement du profil : $e')),
        );
      }
    }
  }
}
