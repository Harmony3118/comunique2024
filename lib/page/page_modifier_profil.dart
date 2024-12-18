import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importation nécessaire pour ImagePicker
import 'package:file_picker/file_picker.dart'; // Importation nécessaire pour FilePicker
import 'dart:io';
import 'bdd/bdd.dart';
import 'conservationUtilisateur.dart';
import 'page_parametre.dart'; // Pour utiliser la classe File

Future<Map<String, Object?>> recupUser(int? id) async {
  final db = await AppDataBase.instance.database;
  final user = await db
      .query('utilisateur', where: 'idUtilisateur = ?', whereArgs: [id]);
  return user.first;
}

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({super.key});

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  int? idUtilisateur;

  // Variables pour stocker les informations du formulaire
  String? anneeEtude;
  String? roleEcole;
  String? _promotion;
  String? _email;
  String? promotion;
  String? email;
  bool stage2A_etranger = false;
  bool stage3A_etranger = false;

  @override
  void initState() {
    super.initState();
    _loadInfos();
  }

  void _loadInfos() async {
    int? id = await getUserId();
    final data = await recupUser(id);
    setState(() {
      idUtilisateur = id;
      _email = data['email'] as String;
      _promotion = data['promotion'].toString();
    });
  }

  final Color customPurple = const Color.fromRGBO(155, 3, 63, 1);

  // Variable pour stocker la photo de profil sélectionnée
  XFile? _profileImage;

  // Fonction pour afficher le menu de sélection de photo
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Changer la photo de profil",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: customPurple),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
                children: [
                  _buildPhotoOption("Prendre une photo", _takePhoto),
                  _buildPhotoOption(
                      "Choisir dans la photothèque", _chooseFromGallery),
                  _buildPhotoOption("Choisir un fichier", _chooseFromFile),
                  _buildPhotoOption("Alumnis", () {}),
                  _buildPhotoOption("Doctorants", () {}),
                  _buildPhotoOption("Bordeaux INP", () {}),
                ],
              ),
              const SizedBox(height: 20),
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
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: customPurple),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(color: customPurple),
              textAlign: TextAlign.center),
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

  // String anneeActuelle(int promotion) {

  // }

  @override
  Widget build(BuildContext context) {
    print('2 : $email');
    print('2 : $promotion');
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Mon profil")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Section "Année scolaire en cours"
              const Center(
                child: Text(
                  "Année scolaire en cours",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(child: Text("Année d'étude")),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText:
                            anneeActuelle(int.parse(_promotion as String)),
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
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(child: Text("Rôle dans l'école")),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      // Action pour ajouter un rôle
                    },
                    color: customPurple,
                  ),
                ],
              ),
              Divider(color: customPurple), // Barre horizontale

              // Section "Photo de profil"
              const Center(
                child: Text(
                  "Photo de profil (portrait de toi)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _showPhotoOptions,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : null, // Affiche la photo sélectionnée
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null, // Affiche une icône si pas d'image
                  ),
                ),
              ),
              Divider(color: customPurple), // Barre horizontale

              // Section "Autres informations"
              const Center(
                child: Text(
                  "Autres informations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Stages", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

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
                  const SizedBox(width: 10),
                  Checkbox(
                    value: stage2A_etranger,
                    onChanged: (value) {
                      setState(() {
                        stage2A_etranger = value!;
                      });
                    },
                    activeColor: customPurple,
                  ),
                  const Text("À l'étranger"),
                ],
              ),
              const SizedBox(height: 10),
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
                  const SizedBox(width: 10),
                  Checkbox(
                    value: stage3A_etranger,
                    onChanged: (value) {
                      setState(() {
                        stage3A_etranger = value!;
                      });
                    },
                    activeColor: customPurple,
                  ),
                  const Text("À l'étranger"),
                ],
              ),
              const SizedBox(height: 20),

              // Promotion et adresse mail
              Row(
                children: [
                  const Expanded(child: Text("Ma promotion")),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: _promotion,
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
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(child: Text("Adresse mail")),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: _email,
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
              const SizedBox(height: 20),

              // Bouton Enregistrer
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: customPurple),
                      ),
                    ),
                    onPressed: () async {
                      if (idUtilisateur != null) {
                        final data = await recupUser(idUtilisateur);
                        Utilisateur u = Utilisateur.fromMap(data);
                        if (email != null) {
                          final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@ensc\.fr$");
                          if (regex.hasMatch(email as String)) {
                            u.email = email as String;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Adresse e-mail invalide")),
                            );
                            email = null;
                          }
                        }
                        if (promotion != null) {
                          u.promotion = int.parse(promotion as String);
                        }
                        if (email != null || promotion != null) {
                          await AppDataBase.instance.updateUtilisateur(u);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pageparametre()),
                          );
                        }
                      }
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
