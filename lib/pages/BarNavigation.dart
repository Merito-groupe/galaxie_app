import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/Boutiques/HomeContents.dart';
import 'package:galaxie_app/pages/Panier/PanierScreen.dart';
import 'package:galaxie_app/pages/ParamettresPages/ParamettreScreen.dart';
 
 
class UserDetailsPage extends StatefulWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
   int _currentIndex = 0;

  final _pages =[
        const AllProdScreen(),
         PanierScreen(),
        const ParamettreScreen(),
 
    
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
          automaticallyImplyLeading: false,
          title: const Text('Shopinkin', style: TextStyle( color: Colors.red),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_currentIndex,
        onTap:(index){
              setState(() => _currentIndex = index);
        },
        showSelectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramettre',
            backgroundColor: Color.fromARGB(255, 170, 14, 14),
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 193, 23, 23),
      ),
      body: _pages [_currentIndex],
    );
  }

  Widget _userInfo(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 220,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.user.photoURL!),
              ),
            ),
          ),
          Text(widget.user.email!),
          Text(widget.user.displayName ?? ""),
          MaterialButton(
            color: Colors.red,
            child: const Text("Sign Out"),
            onPressed: FirebaseAuth.instance.signOut,
          )
        ],
      ),
    );
  }
}
