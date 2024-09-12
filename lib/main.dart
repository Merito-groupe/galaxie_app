import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/StarterScreen.dart';
import 'package:galaxie_app/firebase_options.dart';
import 'package:galaxie_app/model/shop.dart';
import 'package:galaxie_app/pages/Boutiques/ProfilShopViews.dart';
import 'package:galaxie_app/services/authServices.dart';
import 'package:galaxie_app/utility/shop_references.dart';
import 'package:provider/provider.dart';
 
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ShopReferences.init();
  runApp(
    MultiProvider(
      providers: [

        
      StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
      ),
        StreamProvider<List<Shop>>.value(
          initialData: [],
          value: DatabaseService().shops,
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
    final shop =ShopReferences.getUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopinkin',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 250, 85, 3)),
        dividerColor: Colors.black,
        primaryColor: Color.fromARGB(249, 241, 187, 7)
      ),
      // home: StarterScreen(),
 
      home:StarterScreen(),
    );
  }
}
