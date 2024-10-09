import 'package:flutter/material.dart';

class PolitiquesdeRetour extends StatefulWidget {
  const PolitiquesdeRetour({super.key});

  @override
  State<PolitiquesdeRetour> createState() => _PolitiquesdeRetourState();
}

class _PolitiquesdeRetourState extends State<PolitiquesdeRetour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politiques de Retour'),
        backgroundColor: Colors.orange,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Conditions Générales de Retour",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Nous acceptons les retours sous 14 jours à compter de la date de réception de votre commande. "
              "Les produits doivent être retournés dans leur état d'origine, non ouverts et non utilisés. "
              "Nous nous réservons le droit de refuser tout retour ne respectant pas ces conditions.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              "Procédure de Retour",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Pour initier un retour, veuillez contacter notre service client via l'adresse e-mail support@cosmetique.com en indiquant votre numéro de commande et la raison du retour. "
              "Un formulaire de retour vous sera envoyé avec les instructions à suivre. Les frais de retour sont à la charge du client, sauf en cas de produit défectueux.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              "Produits Exemptés de Retour",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Certains produits ne peuvent pas être retournés pour des raisons d'hygiène et de sécurité. "
              "Cela inclut les produits cosmétiques ouverts, les pinceaux, les accessoires de maquillage, ainsi que les produits en promotion ou soldés.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              "Remboursement",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Une fois votre retour reçu et inspecté, nous vous enverrons un e-mail pour vous notifier de l'approbation ou du rejet de votre remboursement. "
              "Si approuvé, votre remboursement sera traité, et un crédit sera automatiquement appliqué à votre mode de paiement d'origine dans un délai de 5 à 10 jours ouvrables.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
