import 'package:flutter/material.dart';

class SanteScreen extends StatefulWidget {
  const SanteScreen({super.key});

  @override
  State<SanteScreen> createState() => _SanteScreenState();
}

class _SanteScreenState extends State<SanteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(213, 241, 47, 47),
            child: Text(
              "A",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          title: Text('Santes'),
          subtitle: Text('Australia'),
        ),
      ),
    );
  }
}
