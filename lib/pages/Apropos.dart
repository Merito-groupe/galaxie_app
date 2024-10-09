import 'package:flutter/material.dart';

class  AproposdeNous extends StatefulWidget {
  const AproposdeNous({super.key});

  @override
  State<AproposdeNous> createState() => _AproposdeNousState();
}

class _AproposdeNousState extends State<AproposdeNous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À Propos de Nous'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Qui sommes-nous ?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Nous sommes une entreprise passionnée par la beauté et le bien-être. '
              'Notre objectif est de fournir des produits cosmétiques de haute qualité qui '
              'répondent aux besoins de nos clients. Nous croyons que chaque personne mérite '
              'de se sentir belle et confiante dans sa peau.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Notre mission',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Notre mission est de proposer des produits cosmétiques innovants et efficaces, '
              'tout en veillant à ce qu\'ils soient accessibles à tous. Nous nous engageons '
              'à utiliser des ingrédients de qualité et à promouvoir la durabilité dans '
              'nos pratiques commerciales.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Nos valeurs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Qualité : Nous croyons en la qualité de nos produits et en leur efficacité.\n'
              '2. Transparence : Nous informons nos clients sur les ingrédients et le processus de fabrication.\n'
              '3. Durabilité : Nous nous engageons à réduire notre impact sur l\'environnement.\n'
              '4. Innovation : Nous recherchons constamment de nouvelles façons d\'améliorer nos produits.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
