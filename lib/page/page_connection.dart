import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_inscription.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_file_actualite.dart';
import 'bdd/bdd.dart';
import 'conservationUtilisateur.dart';

class PageConnection extends StatelessWidget {
  PageConnection({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                padding:
                    EdgeInsets.only(top: screenHeight * 0.1), // 10% de l'écran
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
              SizedBox(height: screenHeight * 0.02), // 2% de l'écran
              // Mdp oublié ???
              const Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: screenHeight * 0.1), // 10% de l'écran
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

  Widget bulle_bordeaux(
      BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        gestionLogin(context);
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
            "Se connecter",
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

  void gestionLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final mdp = passwordController.text.trim();

    final isValidUser =
        await AppDataBase.instance.validerUtilisateur(email, mdp);

    if (isValidUser == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mot de passe incorrect")),
      );
    } else if (isValidUser == -2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adresse mail inconnue")),
      );
    } else {
      await saveUserSession(isValidUser);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BasePage(currentIndex: 0, body: FileActualite()),
        ),
      );
    }
  }

  Widget bulle_claire(
      BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageInscription()),
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
            "S'inscrire",
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
          padding:
              EdgeInsets.only(left: screenWidth * 0.02), // 2% de la largeur
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: const Color.fromARGB(127, 0, 0, 0),
                size: screenHeight * 0.05, // Taille proportionnelle
              ),
              SizedBox(width: screenWidth * 0.05), // 5% de la largeur
              Expanded(
                  child: EmailTextField(
                emailController: emailController,
              )),
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
          padding:
              EdgeInsets.only(left: screenWidth * 0.02), // 2% de la largeur
          child: Row(
            children: [
              Icon(
                Icons.lock_outlined,
                color: const Color.fromARGB(127, 0, 0, 0),
                size: screenHeight * 0.05, // Taille proportionnelle
              ),
              SizedBox(width: screenWidth * 0.05), // 5% de la largeur
              Expanded(
                  child: MdpTextField(passwordController: passwordController)),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe pour le TextField d'email
class EmailTextField extends StatelessWidget {
  final emailController;
  const EmailTextField({required this.emailController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          hintText: 'E-mail',
          hintStyle: TextStyle(
            color: Color.fromARGB(127, 0, 0, 0),
            fontSize: 18, // Taille adaptée
          ),
          fillColor: Color.fromARGB(0, 0, 0, 0),
          filled: true,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre e-mail.';
          }
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Entrez un e-mail valide.';
          }
          return null;
        },
      ),
    );
  }
}

// Classe pour le TextField du mdp
class MdpTextField extends StatelessWidget {
  final passwordController;
  const MdpTextField({required this.passwordController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: TextStyle(
            color: Color.fromARGB(127, 0, 0, 0),
            fontSize: 18, // Taille adaptée
          ),
          fillColor: Color.fromARGB(0, 0, 0, 0),
          filled: true,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer votre mot de passe.';
          }
          return null;
        },
      ),
    );
  }
}
