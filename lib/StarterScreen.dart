import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/UserDetaille.dart';
 
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
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
          height: 50,
          child: MaterialButton(
            color: Color.fromARGB(255, 219, 77, 67),
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

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(user: userCredential.user!),
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}
