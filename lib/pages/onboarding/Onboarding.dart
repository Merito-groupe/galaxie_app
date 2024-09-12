import 'package:flutter/material.dart';
import 'package:galaxie_app/StarterScreen.dart';
 
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage('assets/ShopInKin.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 4),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: 'Nom Boutique',
                          hintText: 'Nom Boutique',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 4),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: 'Adress Physique',
                          hintText: 'Adress Physique',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 4),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: 'RCCM',
                          hintText: 'RCCM',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 4),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: 'Page Facebook ou Instagram',
                          hintText: 'Page Facebook ou Instagram',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 14, left: 12),
                    child: MaterialButton(
                      height: 50,
                      color: const Color.fromARGB(255, 235, 212, 212),
                      child: const Text(
                        "Valider",
                        style: TextStyle(
                          color: Color.fromARGB(255, 239, 67, 67), // Text color
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StarterScreen()),
                        );
                      },
                    ),
                  ),
 

                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
