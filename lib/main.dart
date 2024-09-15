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
  
      home:StarterScreen(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Ajoutez ceci pour l'initialisation Firebase
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:galaxie_app/UserDetaille.dart';
// import 'package:google_sign_in/google_sign_in.dart';
 
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Assurez-vous que Flutter est initialisé
//   await Firebase.initializeApp(); // Initialisez Firebase ici
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Maison GALAXY',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: SignInPage(),
//     );
//   }
// }

// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     // Check if the user is already logged in
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     User? user = _auth.currentUser;
//     setState(() {
//       _user = user;
//     });
//   }

//   Future<void> _signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//       if (googleUser != null) {
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         UserCredential userCredential =
//             await _auth.signInWithCredential(credential);

//         setState(() {
//           _user = userCredential.user;
//         });

//         // Navigate to the UserDetailsPage after successful login
//         if (_user != null) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => UserDetailsPage(user: _user!),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error during Google Sign-In: $e');
//     }
//   }

//   Future<void> _signOut() async {
//     await _auth.signOut();
//     setState(() {
//       _user = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Maison GALAXY'),
//         backgroundColor: Color(0xFFD78914),
//       ),
//       body: _user == null ? _buildSignInButton() : _buildSignInButton(),
//     );
//   }

//   Widget _buildSignInButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _signInWithGoogle,
//         child: Text('Se connecter avec Google'),
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.white, backgroundColor: Color(0xFFD78914),
//         ),
//       ),
//     );
//   }

   
// }
