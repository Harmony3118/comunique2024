import 'package:comunique2024/page/page_connection.dart';
import 'package:comunique2024/page/page_inscription_suite.dart';
import 'package:flutter/material.dart';

class PageInscription extends StatelessWidget {
  const PageInscription({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Image centrée
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.1), // 10% de l'écran
                child: Center(
                  child: image(context, screenWidth),
                ),
              ),
              SizedBox(height: screenHeight * 0.08), // 8% de l'écran
              // ID
              id(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.02), // 2% de l'écran
              // MDP
              mdp(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.15), // 15% de l'écran
              // Bulle bordeaux
              bulle_bordeaux(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03), // 3% de l'écran
              // Bulle claire
              bulle_claire(context, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.15), // 15% de l'écran
            ],
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context, double screenWidth) {
    return const Image(
      image: AssetImage('assets/Logo.png'),
      width: 200, // Taille fixe
      height: 200, // Taille fixe
      fit: BoxFit.cover,
    );
  }

  Widget bulle_bordeaux(BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageInscriptionSuite()),
        );
      },
      child: Container(
        width: screenWidth * 0.8, // 80% de la largeur de l'écran
        height: screenHeight * 0.06, // 6% de la hauteur de l'écran
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 100, 3, 41),
          borderRadius: BorderRadius.circular(30), // Bords arrondis
        ),
        child: const Center(
          child: Text(
            "S'inscrire",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget bulle_claire(BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageConnection()),
        );
      },
      child: Container(
        width: screenWidth * 0.8, // 80% de la largeur de l'écran
        height: screenHeight * 0.06, // 6% de la hauteur de l'écran
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 215, 215),
          borderRadius: BorderRadius.circular(30), // Bords arrondis
        ),
        child: const Center(
          child: Text(
            "Se connecter",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget id(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.65, // 65% de la largeur de l'écran
      height: screenHeight * 0.08, // 8% de la hauteur de l'écran
      decoration: const BoxDecoration(
        color: Colors.transparent, // Rendre le fond transparent
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 0, 0, 0), // Couleur de la bordure
            width: 1.5, // Épaisseur de la bordure
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02), // 2% de la largeur
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: const Color.fromARGB(127, 0, 0, 0),
                size: screenHeight * 0.05, // Taille proportionnelle
              ),
              SizedBox(width: screenWidth * 0.05), // 5% de la largeur
              const Expanded(child: EmailTextField()),
            ],
          ),
        ),
      ),
    );
  }

  Widget mdp(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.65, // 65% de la largeur de l'écran
      height: screenHeight * 0.08, // 8% de la hauteur de l'écran
      decoration: const BoxDecoration(
        color: Colors.transparent, // Rendre le fond transparent
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 0, 0, 0), // Couleur de la bordure
            width: 1.5, // Épaisseur de la bordure
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02), // 2% de la largeur
          child: Row(
            children: [
              Icon(
                Icons.lock_outlined,
                color: const Color.fromARGB(127, 0, 0, 0),
                size: screenHeight * 0.05, // Taille proportionnelle
              ),
              SizedBox(width: screenWidth * 0.05), // 5% de la largeur
              const Expanded(child: MdpTextField()),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe pour le TextField d'email
class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'E-mail',
          hintStyle: TextStyle(
            color: Color.fromARGB(127, 0, 0, 0),
            fontSize: 18, // Taille adaptée
          ),
          fillColor: Color.fromARGB(0, 0, 0, 0),
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// Classe pour le TextField du mdp
class MdpTextField extends StatelessWidget {
  const MdpTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: TextStyle(
            color: Color.fromARGB(127, 0, 0, 0),
            fontSize: 18, // Taille adaptée
          ),
          fillColor: Color.fromARGB(0, 0, 0, 0),
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

