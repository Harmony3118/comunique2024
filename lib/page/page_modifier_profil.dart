import 'package:flutter/material.dart';

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();

  // Variables pour stocker les informations du formulaire
  String? anneeEtude;
  String? roleEcole;
  String? promotion;
  String? email;
  bool stage2A = false;
  bool stage3A = false;
  bool stage2A_etranger = false;
  bool stage3A_etranger = false;

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
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        hintText: '2A, 3A, etc.',
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
                  ),
                ],
              ),
              Divider(color: Colors.purple),  // Barre horizontale violette

              // Section "Photo de profil"
              Center(
                child: Text(
                  "Photo de profil (portrait de toi)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
              Divider(color: Colors.purple),  // Barre horizontale violette

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

              // Input pour 2A et 3A avec checkbox "À l'étranger"
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '2A',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
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
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
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
                  ),
                  Text("À l'étranger"),
                ],
              ),
              SizedBox(height: 20),

              // Promotion et Adresse mail
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
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
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
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      onChanged: (value) => email = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Bouton Enregistrer stylisé comme les autres champs
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.purple),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Enregistrer les modifications du profil
                      }
                    },
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(color: Colors.purple),
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