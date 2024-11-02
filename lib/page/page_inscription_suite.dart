import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_file_actualite.dart';

class PageInscriptionSuite extends StatefulWidget {
  const PageInscriptionSuite({super.key});

  @override
  _PageInscriptionSuiteState createState() => _PageInscriptionSuiteState();
}

class _PageInscriptionSuiteState extends State<PageInscriptionSuite> {
  File? _image; // Variable pour stocker l'image sélectionnée
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView( // Permet le défilement
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Icône de retour en haut à gauche
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 350),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Action de retour à l'écran précédent
                },
              ),
            ),
            Center(
              child: image(context), // Centered image
            ),
            const SizedBox(height: 10), // Espace entre l'image et "Mes préférences"
            
              // Mes préférences
              mes_prefs(context),
              const SizedBox(height: 20), // Espace entre les sections

              // Mes données
              mes_donnees(context),
              const SizedBox(height: 60), // Espace avant les boutons
              
              // Bulle bordeaux
              bulle_bordeaux(context),
              const SizedBox(height: 30), // Espace entre les deux boutons
              
              // Bulle claire
              bulle_claire(context),
              const SizedBox(height: 200), // Espace en bas pour le défilement
            ],
          ),
        ),
      ),
    );
  }

  Widget image(BuildContext context) {
    return const Image(
      image: AssetImage('assets/Logo.png'),
      width: 160,
      height: 160,
      fit: BoxFit.cover,
    );
  }

  Widget mes_prefs(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 50,
          child: const Center(
            child: Text(
              "Mes préférences",
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 400,
          height: 50,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(
                  "Type de calendrier",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                SizedBox(width: 40),
                Expanded(child: DropdownExample()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget mes_donnees(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 50,
          child: const Center(
            child: Text(
              "Mes données",
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Photo de profil
        Container(
          width: 400,
          height: 50,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                const Text(
                  "Photo de profil",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: _pickImageFromGallery,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _takePhoto,
                ),
              ],
            ),
          ),
        ),
        // Mon nom
        buildTextFieldRow("Mon nom", YearTextField()),
        // Mon prénom
        buildTextFieldRow("Mon prénom", YearTextField()),
        // Mon année
        buildTextFieldRow("Mon année", YearTextField()),
        // Email
        buildTextFieldRow("Mail", EmailTextField()),
      ],
    );
  }

  Widget buildTextFieldRow(String label, Widget textField) {
    return Container(
      width: 400,
      height: 50,
      color: const Color.fromARGB(0, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 21,
              ),
            ),
            const SizedBox(width: 40),
            Expanded(child: textField),
          ],
        ),
      ),
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
            borderRadius: BorderRadius.circular(19),
          ),
          child: const Center(
            child: Text(
              "Continuer",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  Widget bulle_claire(BuildContext context) {
    return Container(
      width: 299,
      height: 43,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 215, 215),
        borderRadius: BorderRadius.circular(19),
      ),
      child: const Center(
        child: Text(
          "Passer cette étape",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  // Fonction pour choisir une image à partir de la galerie
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Fonction pour prendre une photo avec l'appareil photo
  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}


// case intéractive calendrier

class DropdownExample extends StatefulWidget {
  const DropdownExample({super.key});

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  final List<String> options = ["Jour", "Semaine", "Mois"];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: const Text("Choisir"),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue; // Met à jour la valeur sélectionnée
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// Classe pour le TextField d'année
class YearTextField extends StatelessWidget {
  const YearTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '',
          fillColor: Colors.grey[200],
          filled: true,
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
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '',
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
