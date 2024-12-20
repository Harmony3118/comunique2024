import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_reservation_salle_3.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      fleche(context),
                      const SizedBox(width: 10),
                      Expanded(
                        child: reserver(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Espacement après le texte
                  const Divider(thickness: 2, color: Colors.black), // Ligne
                ],
              ),
            ),
            const SizedBox(height: 20),
            horaire(context),
            const SizedBox(height: 20), // Espacement entre la dernière section et le bouton
            envoyerButton(context),
          ],
        ),
      ),
    );
  }
}

Widget reserver(BuildContext context) {
  return const Text(
    "Réserver une salle",
    style: TextStyle(
      color: Colors.black,
      fontSize: 23,
      fontWeight: FontWeight.w200,
    ),
    textAlign: TextAlign.center,
  );
}

Widget fleche(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios, size: 20.0),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BasePage(currentIndex: 4, body: ContactPage()),
        ),
      );
    },
  );
}

Widget horaire(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 400,
        height: 50,
        child: const Center(
          child: Text(
            "Salle O205",
            style: TextStyle(
              color: Color(0xFF640329), // Changer la couleur du texte
              fontSize: 30, // Augmenter la taille du texte
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(height: 10), // Ajuster l'espacement entre le titre et les champs
      _buildField("Objet de la réservation", const JourTextField()),
      const SizedBox(height: 10),
      _buildField("Pour qui", const HeureTextField()),
      const SizedBox(height: 10),
      _buildField("Nombre de personnes", const NombrePersonnesTextField()),
    ],
  );
}

Widget _buildField(String label, Widget textField) {
  return Container(
    width: 400,
    color: const Color.fromARGB(0, 255, 255, 255),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 4), // Espacement entre le texte et le champ
          textField,
        ],
      ),
    ),
  );
}

class NombrePersonnesTextField extends StatelessWidget {
  const NombrePersonnesTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Accepter uniquement les chiffres
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)),
          ),
          hintText: '',
          fillColor: Colors.grey[350],
          filled: true,
        ),
      ),
    );
  }
}

class JourTextField extends StatelessWidget {
  const JourTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return _commonTextField();
  }
}

class HeureTextField extends StatelessWidget {
  const HeureTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return _commonTextField();
  }
}

Widget _commonTextField() {
  return Container(
    width: 200,
    height: 50,
    child: TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF640329)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF640329)),
        ),
        hintText: '',
        fillColor: Colors.grey[350],
        filled: true,
      ),
      keyboardType: TextInputType.text,
    ),
  );
}

Widget envoyerButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp3()),
            );
          },
          child: Text(
            'Envoyer un mail',
            style: const TextStyle(
              color: Color(0xFF640329),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}