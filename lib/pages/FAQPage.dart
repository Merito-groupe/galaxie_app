import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<Map<String, dynamic>> _faqList = [
    {
      'question': 'Comment puis-je passer une commande ?',
      'answer': 'Pour passer une commande, parcourez notre catalogue de produits, ajoutez les articles souhaités à votre panier, puis suivez les instructions de paiement.'
    },
    {
      'question': 'Quels modes de paiement acceptez-vous ?',
      'answer': 'Nous acceptons les cartes de crédit, PayPal, et d\'autres méthodes de paiement sécurisées.'
    },
    {
      'question': 'Comment puis-je suivre ma commande ?',
      'answer': 'Après avoir passé votre commande, vous recevrez un e-mail de confirmation avec un lien de suivi. Vous pouvez également suivre votre commande dans votre compte client.'
    },
    {
      'question': 'Que faire si je reçois un produit défectueux ?',
      'answer': 'Si vous recevez un produit défectueux, veuillez nous contacter immédiatement avec votre numéro de commande, et nous vous aiderons à le remplacer ou à le rembourser.'
    },
    {
      'question': 'Puis-je retourner un produit ?',
      'answer': 'Oui, vous pouvez retourner un produit dans les 14 jours suivant sa réception, à condition qu\'il soit non ouvert et dans son état d\'origine.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foire aux Questions',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: _faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              _faqList[index]['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _faqList[index]['answer'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
