import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_inscription.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_file_actualite.dart';

class PageConnection extends StatelessWidget {
  const PageConnection({super.key});

  // Création d'une class pour que le code principal soit lisible (comme les fonctions)
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body : Container(
      // Pour créer une boîte
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          // Image centrée
          Positioned(
            top: 115,
            left: (MediaQuery.of(context).size.width - 200) / 2,
            child: image(context),
          ),
          // Bulle bordeaux
          Positioned(
            top: 690, // Positionnement à 633 pixels du haut
            left: (MediaQuery.of(context).size.width - 299) /
                2, // Centrage horizontal
            child: bulle_bordeaux(context),
          ),
          // Bulle claire
          Positioned(
            top: 760, // Positionnement à 633 pixels du haut
            left: (MediaQuery.of(context).size.width - 299) /
                2, // Centrage horizontal
            child: bulle_claire(context),
          ),
          // ID
          Positioned(
            top: 410, // Positionnement à 633 pixels du haut
            left: (MediaQuery.of(context).size.width - 262) /
                2, // Centrage horizontal
            child: id(context),
          ),
          // MDP
          Positioned(
            top: 510, // Positionnement à 633 pixels du haut
            left: (MediaQuery.of(context).size.width - 262) /
                2, // Centrage horizontal
            child: mdp(context),
          ),
            // Mdp oublié ???
              Positioned(
                top: 580,
                left: (MediaQuery.of(context).size.width - 262) / 2,
                child: const Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
          ),
        ],
      ),
      ),
    );
  }

  
  Widget image(BuildContext context) {
    return const Image(
      image: AssetImage('assets/Logo.png'),
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget bulle_bordeaux(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BasePage(currentIndex: 0, body: FileActualite()),
            ));
      },
      child: Container(
        width: 299,
        height: 43,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 100, 3, 41),
          borderRadius: BorderRadius.circular(19), // Bords arrondis
        ),
        child: const Center(
          // Centrage du texte
          child: Text(
            "Se connecter", // Le texte à afficher
            style: TextStyle(
              color: Colors.white, // Couleur du texte
              fontSize: 24,
              fontWeight: FontWeight.bold, // Met le texte en gras
            ),
          ),
        ),
      ),
    );
  }
}

Widget bulle_claire(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageInscription()),
      );
    },
    child: Container(
      width: 299,
      height: 43,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 215, 215),
        borderRadius: BorderRadius.circular(19), // Bords arrondis
      ),
      child: const Center(
        // Centrage du texte
        child: Text(
          "S'inscrire", // Le texte à afficher
          style: const TextStyle(
            color: Colors.black, // Couleur du texte
            fontSize: 24,
          ),
        ),
      ),
    ),
  );
}

Widget id(BuildContext context) {
  return Container(
    width: 262,
    height: 58,
    decoration: const BoxDecoration(
      color: Colors.transparent, // Rendre le fond transparent
      border: Border(
        bottom: BorderSide(
          color: Color.fromARGB(255, 0, 0, 0), // Couleur de la bordure
          width: 1.0, // Épaisseur de la bordure
        ),
      ),
    ),
    child: const Align(
      alignment: Alignment.centerLeft, // Aligne le texte à gauche
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0), // Ajustez la valeur selon vos besoins
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Color.fromARGB(127, 0, 0, 0),
              size: 50, // Taille de l'icône
            ),
            const SizedBox(width: 20), // Ajustez la valeur selon vos besoins
            Expanded(child: EmailTextField()),
          ],
        ),
      ),
    ),
  );
}

Widget mdp(BuildContext context) {
  return Container(
    width: 262,
    height: 58,
    decoration: const BoxDecoration(
      color: Colors.transparent, // Rendre le fond transparent
      border: Border(
        bottom: BorderSide(
          color: Color.fromARGB(255, 0, 0, 0), // Couleur de la bordure
          width: 1.0, // Épaisseur de la bordure
        ),
      ),
    ),
    child: const Align(
      alignment: Alignment.centerLeft, // Aligne le texte à gauche
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0), // Ajustez la valeur selon vos besoins
        child: Row(
          children: [
            const Icon(
              Icons.lock_outlined,
              color: Color.fromARGB(127, 0, 0, 0),
              size: 50, // Taille de l'icône
            ),
            const SizedBox(width: 10), // Ajustez la valeur selon vos besoins
            Expanded(child: MdpTextField()),
          ],
        ),
      ),
    ),
  );
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
            fontSize: 24, // Taille de la police pour le texte d'indication
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
            fontSize: 24, // Taille de la police pour le texte d'indication
          ),
          fillColor: Color.fromARGB(0, 0, 0, 0),
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
