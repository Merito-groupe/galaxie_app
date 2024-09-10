import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/StarterScreen.dart';
import 'package:galaxie_app/firebase_options.dart';
import 'package:galaxie_app/services/authServices.dart';
import 'package:provider/provider.dart';
 
import 'package:firebase_core/firebase_core.dart';
 
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
      title: 'Shopinkin',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Color.fromARGB(255, 250, 221, 3)),
        dividerColor: Colors.black,
        primaryColor: Color.fromARGB(249, 241, 187, 7)
      ),
       home: StarterScreen(),
 
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tam Tam',
//       initialRoute: AppRoutes.home,
//       routes: AppRoutes.routes,
//     );
//   }
// }


// // lib/main.dart

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:tamtam_admin/routes/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: AppRoutes.home,
//       onGenerateRoute: AppRoutes.generateRoute,
//     );
//   }
// }
