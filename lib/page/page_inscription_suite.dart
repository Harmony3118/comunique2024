import 'dart:io';
import 'package:flutter/material.dart';
import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/bdd.dart';
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
  bool _formSubmitted = false; // Indique si le formulaire a été soumis

  // Controller pour récupoérer le champs du form
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController promotionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // libère les controlleurs : qu'est ce que c'est ?
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    promotionController.dispose();
    super.dispose();
  }

  // insérer un utilisateur
  void saveUser() async {
    if (formKey.currentState!.validate()) {
      final Utilisateur utilisateur = Utilisateur(
        nom: nomController.text,
        prenom: prenomController.text,
        email: emailController.text,
        promotion: int.parse(promotionController.text),
      );

      await AppDataBase.instance.insertUtilisateur(utilisateur);

      // Affiche le message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Utilisateur ajouté !")),
      );

      // Réinitialiser les champs
      nomController.clear();
      prenomController.clear();
      emailController.clear();
      promotionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child : Container(
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
        Container(
          width: 400,
          height: 50,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Text(
                  "Mon nom",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                const SizedBox(width: 73),
                Expanded(
                    child: YearTextField(
                  controller: nomController,
                  type: TextInputType.name,
                  formSubmitted: _formSubmitted,
                )),
              ],
            ),
          ),
        ),
        Container(
          width: 400,
          height: 50,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Text(
                  "Mon prénom",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                    child: YearTextField(
                  controller: prenomController,
                  type: TextInputType.name,
                  formSubmitted: _formSubmitted,
                )),
              ],
            ),
          ),
        ),
        Container(
          width: 400,
          height: 50,
          color: const Color.fromRGBO(255, 255, 255, 0),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Text(
                  "Mon année",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                const SizedBox(width: 55),
                Expanded(
                    child: YearTextField(
                  controller: promotionController,
                  type: TextInputType.number,
                  formSubmitted: _formSubmitted,
                )),
              ],
            ),
          ),
        ),
        Container(
          width: 400,
          height: 50,
          color: const Color.fromARGB(0, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Text(
                  "Mail",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 21,
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: YearTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    formSubmitted: _formSubmitted,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget bulle_bordeaux(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
        _formSubmitted = true; // Activer les validations
      });

      if (formKey.currentState!.validate()) {
        saveUser(); // Sauvegarder l'utilisateur
          

/*
          // test print
          final db = await AppDataBase.instance.database;
          List<Map<String, dynamic>> utilisateurs =
              await db.query('utilisateur');
          print(utilisateurs);
          // fin test
*/

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BasePage(currentIndex: 0, body: FileActualite()),
              ),);
              } else {
        // Afficher un message ou autre si non valide
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Veuillez remplir tous les champs obligatoires."),
          ),
        );
      }

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
    return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Passer cette étape ?"),
            content: const Text(
                "Vous n'avez pas rempli vos informations. Êtes-vous sûr de vouloir passer cette étape ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fermer la boîte de dialogue
                },
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fermer la boîte de dialogue
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BasePage(
                        currentIndex: 0,
                        body: FileActualite(), // Page d'accueil
                      ),
                    ),
                  );
                },
                child: const Text("Confirmer"),
              ),
            ],
          );
        },
      );
    },
    child: Container(
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
  TextEditingController controller;
  TextInputType type;
  final bool formSubmitted;

  YearTextField({super.key, required this.controller, required this.type, required this.formSubmitted,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextFormField(
        autovalidateMode: formSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '',
          fillColor: Colors.grey[200],
          filled: true,
          errorStyle: TextStyle(height: 0), // Réduit la hauteur de l'erreur
        ),
        controller: controller,
        keyboardType: type,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez remplir le champs';
          }
          return null; // Pas d'erreur
        },
      ),
    );
  }
}

// Classe pour le TextField d'email
class EmailTextField extends StatelessWidget {
  TextEditingController controller;
  EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '',
          fillColor: Colors.grey[200],
          filled: true,
        ),
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez remplir le champs';
          }
          return null;
        },
      ),
    );
  }
}
