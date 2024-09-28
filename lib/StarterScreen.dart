
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:galaxie_app/UserDetaille.dart';

// class StarterScreen extends StatefulWidget {
//   const StarterScreen({super.key});

//   @override
//   State<StarterScreen> createState() => _StarterScreenState();
// }

// class _StarterScreenState extends State<StarterScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _auth.authStateChanges().listen((event) {
//       setState(() {
//         _user = event;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _googleSignInButton(),
//           const SizedBox(height: 20),
//           _anonymousSignInButton(),
//         ],
//       ),
//     );
//   }

//   // Bouton de connexion Google
//   Widget _googleSignInButton() {
//     return Center(
//       child: SizedBox(
//           height: 50,
//           child: MaterialButton(
//             color: const Color.fromARGB(255, 219, 77, 67),
//             child: const Text(
//               "Connectez-vous avec Google",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 250, 248, 248),
//               ),
//             ),
//             onPressed: _handleGoogleSignIn,
//           )),
//     );
//   }

//   // Bouton de connexion anonyme
//   Widget _anonymousSignInButton() {
//     return Center(
//       child: SizedBox(
//           height: 50,
//           child: MaterialButton(
//             color: const Color.fromARGB(255, 100, 100, 100),
//             child: const Text(
//               "Connexion anonyme",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 250, 248, 248),
//               ),
//             ),
//             onPressed: _handleAnonymousSignIn,
//           )),
//     );
//   }

//   // Gestion de la connexion Google
//   void _handleGoogleSignIn() async {
//     try {
//       GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
//       UserCredential userCredential =
//           await _auth.signInWithProvider(_googleAuthProvider);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => UserDetailsPage(user: userCredential.user!),
//         ),
//       );
//     } catch (error) {
//       print(error);
//     }
//   }

//   // Gestion de la connexion anonyme
//   void _handleAnonymousSignIn() async {
//     try {
//       UserCredential userCredential = await _auth.signInAnonymously();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => UserDetailsPage(user: userCredential.user!),
//         ),
//       );
//     } catch (error) {
//       print("Erreur lors de la connexion anonyme : $error");
//     }
//   }
// }





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//  import 'package:galaxie_app/homepage.dart';

// class StarterScreen extends StatefulWidget {
//   const StarterScreen({super.key});

//   @override
//   State<StarterScreen> createState() => _StarterScreenState();
// }

// class _StarterScreenState extends State<StarterScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser(); // Appel de la méthode pour charger les informations de l'utilisateur
//   }

//   // Méthode pour charger les informations de l'utilisateur connecté
//   void _loadUser() {
//     User? currentUser = _auth.currentUser; // Récupération de l'utilisateur actuel
//     if (currentUser != null) {
//       setState(() {
//         _user = currentUser;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_user != null ? 'Bienvenue, ${_user!.displayName}' : 'Connexion'), // Affiche le nom si l'utilisateur est connecté
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (_user != null)
//             Text('Vous êtes connecté en tant que ${_user!.email}')
//           else
//             Column(
//               children: [
//                 _googleSignInButton(),
//                 const SizedBox(height: 20),
//                 _anonymousSignInButton(),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   // Bouton de connexion Google
//   Widget _googleSignInButton() {
//     return Center(
//       child: SizedBox(
//           height: 50,
//           child: MaterialButton(
//             color: const Color.fromARGB(255, 219, 77, 67),
//             child: const Text(
//               "Connectez-vous avec Google",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 250, 248, 248),
//               ),
//             ),
//             onPressed: _handleGoogleSignIn,
//           )),
//     );
//   }

//   // Bouton de connexion anonyme
//   Widget _anonymousSignInButton() {
//     return Center(
//       child: SizedBox(
//           height: 50,
//           child: MaterialButton(
//             color: const Color.fromARGB(255, 100, 100, 100),
//             child: const Text(
//               "Connexion anonyme",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 250, 248, 248),
//               ),
//             ),
//             onPressed: _handleAnonymousSignIn,
//           )),
//     );
//   }

//   // Gestion de la connexion Google
//   void _handleGoogleSignIn() async {
//     try {
//       GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
//       UserCredential userCredential =
//           await _auth.signInWithProvider(_googleAuthProvider);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(user: userCredential.user!),
//         ),
//       );
//     } catch (error) {
//       print(error);
//     }
//   }

//   // Gestion de la connexion anonyme
//   void _handleAnonymousSignIn() async {
//     try {
//       UserCredential userCredential = await _auth.signInAnonymously();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>  HomePage(user: userCredential.user!),
//         ),
//       );
//     } catch (error) {
//       print("Erreur lors de la connexion anonyme : $error");
//     }
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/homepage.dart';

class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    // Assurez-vous que la navigation ne se produit qu'une fois que le cadre est prêt
    WidgetsBinding.instance.addPostFrameCallback((_) {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        setState(() {
          _user = currentUser;
        });

        // Navigation vers HomePage après avoir vérifié l'utilisateur
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: _user!), // Remplacez par l'interface de HomePage
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user != null
            ? 'Bienvenue, ${_user!.displayName}'
            : 'Connexion'),
      ),
      body: Center(
        child: _user == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _googleSignInButton(),
                  const SizedBox(height: 20),
                  _anonymousSignInButton(),
                ],
              )
            : const CircularProgressIndicator(), // Affiche un loader pendant que la navigation est en cours
      ),
    );
  }

  // Bouton de connexion Google
  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
          height: 50,
          child: MaterialButton(
            color: const Color.fromARGB(255, 219, 77, 67),
            child: const Text(
              "Connectez-vous avec Google",
              style: TextStyle(
                color: Color.fromARGB(255, 250, 248, 248),
              ),
            ),
            onPressed: _handleGoogleSignIn,
          )),
    );
  }

  // Bouton de connexion anonyme
  Widget _anonymousSignInButton() {
    return Center(
      child: SizedBox(
          height: 50,
          child: MaterialButton(
            color: const Color.fromARGB(255, 100, 100, 100),
            child: const Text(
              "Connexion anonyme",
              style: TextStyle(
                color: Color.fromARGB(255, 250, 248, 248),
              ),
            ),
            onPressed: _handleAnonymousSignIn,
          )),
    );
  }

  // Gestion de la connexion Google
  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      setState(() {
        _user = userCredential.user;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: userCredential.user!), // Navigation après succès
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  // Gestion de la connexion anonyme
  void _handleAnonymousSignIn() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      setState(() {
        _user = userCredential.user;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: userCredential.user!), // Navigation après succès
        ),
      );
    } catch (error) {
      print("Erreur lors de la connexion anonyme : $error");
    }
  }
}
