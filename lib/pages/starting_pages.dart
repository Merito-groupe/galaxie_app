import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/add_advertisement_page.dart';
import 'package:galaxie_app/pages/parametre_page.dart';


class StartingPages extends StatefulWidget {
  const StartingPages({super.key});

  @override
  State<StartingPages> createState() => _StartingPagesState();
}

class _StartingPagesState extends State<StartingPages> {
  int _selectedIndex = 0;

  static   List<Widget> _pages = <Widget>[
    AddAdvertisementPage(),
    AddAdvertisementPage(),
    ParametrePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Ad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill),
            label: 'Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
