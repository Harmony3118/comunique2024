import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Importation nécessaire pour ImagePicker
import 'package:file_picker/file_picker.dart';    // Importation nécessaire pour FilePicker
import 'dart:io';  // Pour utiliser la classe File

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Variables pour stocker les informations du formulaire
  String? anneeEtude;
  String? roleEcole;
  String? promotion;
  String? email;
  bool stage2A_etranger = false;
  bool stage3A_etranger = false;

  final Color customPurple = Color.fromRGBO(155, 3, 63, 1);

  // Variable pour stocker la photo de profil sélectionnée
  XFile? _profileImage;

  // Fonction pour afficher le menu de sélection de photo
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Changer la photo de profil",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: customPurple),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
                children: [
                  _buildPhotoOption("Prendre une photo", _takePhoto),
                  _buildPhotoOption("Choisir dans la photothèque", _chooseFromGallery),
                  _buildPhotoOption("Choisir un fichier", _chooseFromFile),
                  _buildPhotoOption("Alumnis", () {}),
                  _buildPhotoOption("Doctorants", () {}),
                  _buildPhotoOption("Bordeaux INP", () {}),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: customPurple),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Fermer le menu
                },
                child: Text(
                  "Valider",
                  style: TextStyle(color: customPurple),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Fonction pour créer chaque option de photo
  Widget _buildPhotoOption(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: customPurple),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: customPurple), textAlign: TextAlign.center),
        ),
      ),
    );
  }

  // Méthode pour prendre une photo avec la caméra
  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
      print("Photo prise: ${pickedFile.path}");
    }
  }

  // Méthode pour choisir une photo depuis la galerie
  Future<void> _chooseFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
      print("Photo choisie depuis la galerie: ${pickedFile.path}");
    }
  }

  // Méthode pour choisir un fichier image depuis l'explorateur de fichiers
  Future<void> _chooseFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );
    if (result != null) {
      setState(() {
        _profileImage = XFile(result.files.single.path!);
      });
      print("Fichier image sélectionné: ${result.files.single.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Mon profil")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Section "Année scolaire en cours"
              Center(
                child: Text(
                  "Année scolaire en cours",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text("Année d'étude")),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                      ),
                      onChanged: (value) => anneeEtude = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text("Rôle dans l'école")),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      // Action pour ajouter un rôle
                    },
                    color: customPurple,
                  ),
                ],
              ),
              Divider(color: customPurple),  // Barre horizontale

              // Section "Photo de profil"
              Center(
                child: Text(
                  "Photo de profil (portrait de toi)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _showPhotoOptions,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : null,  // Affiche la photo sélectionnée
                    child: _profileImage == null
                        ? Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,  // Affiche une icône si pas d'image
                  ),
                ),
              ),
              Divider(color: customPurple),  // Barre horizontale

              // Section "Autres informations"
              Center(
                child: Text(
                  "Autres informations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text("Stages", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              // Champs pour les stages 2A et 3A avec checkbox "À l'étranger"
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '2A',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                      ),
                      onChanged: (value) {
                        // Sauvegarder les infos de stage 2A
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: stage2A_etranger,
                    onChanged: (value) {
                      setState(() {
                        stage2A_etranger = value!;
                      });
                    },
                    activeColor: customPurple,
                  ),
                  Text("À l'étranger"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '3A',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                      ),
                      onChanged: (value) {
                        // Sauvegarder les infos de stage 3A
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: stage3A_etranger,
                    onChanged: (value) {
                      setState(() {
                        stage3A_etranger = value!;
                      });
                    },
                    activeColor: customPurple,
                  ),
                  Text("À l'étranger"),
                ],
              ),
              SizedBox(height: 20),

              // Promotion et adresse mail
              Row(
                children: [
                  Expanded(child: Text("Promotion")),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                      ),
                      onChanged: (value) => promotion = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text("Adresse mail")),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: customPurple),
                        ),
                      ),
                      onChanged: (value) => email = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Bouton Enregistrer
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: customPurple),
                      ),
                    ),
                    onPressed: () {
                      // Action pour enregistrer
                    },
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(color: customPurple),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}