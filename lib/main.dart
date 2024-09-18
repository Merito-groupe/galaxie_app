import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/StarterScreen.dart';
import 'package:galaxie_app/firebase_options.dart';
import 'package:galaxie_app/services/authServices.dart';
import 'package:provider/provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   runApp(
    MultiProvider(
      providers: [

        
      StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
      ),
         
      ],
      child:   MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
       title: 'Maison GALAXY',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
  
      home:  StarterScreen(),
    );
  }
}


 