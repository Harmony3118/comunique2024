import 'package:flutter/material.dart';
import 'package:comunique2024/widget/card_annuaire.dart';

class AnnuairePage extends StatefulWidget {
  const AnnuairePage({Key? key}) : super(key: key);

  @override
  _AnnuairePageState createState() => _AnnuairePageState();
}

class _AnnuairePageState extends State<AnnuairePage> {
  List<String> categories = ['Élèves', 'Professeurs', 'Administration'];

  List<List<Map<String, String>>> infos = [
    [
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      // ... Ajoutez d'autres élèves ici
    ],
    [
      {
        'name': 'Dr. Smith',
        'email': 'smith@example.com',
        'role': 'Professeur',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Prof. Johnson',
        'email': 'johnson@example.com',
        'role': 'Professeur',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      // ... Ajoutez d'autres professeurs ici
    ],
    [
      {
        'name': 'Eva Davis',
        'email': 'eva.davis@example.com',
        'role': 'Administrateur',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Chris Brown',
        'email': 'chris.brown@example.com',
        'role': 'Administrateur',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Alice',
        'email': 'alice@example.com',
        'role': 'Étudiante',
        'image': 'assets/profil.png'
      },
      {
        'name': 'Bob',
        'email': 'bob@example.com',
        'role': 'Étudiant',
        'image': 'assets/profil.png'
      },
      // ... Ajoutez d'autres membres de l'administration ici
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Désactive la flèche de retour automatique de l'AppBar
        title: const Text('Annuaire Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Rôle', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor:
                        const Color.fromARGB(255, 125, 49, 74), // Fond rose
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
                        0), // 20% de la largeur de l'écran
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Statut', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor:
                        const Color.fromARGB(255, 125, 49, 74), // Fond rose
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
                        0), // 20% de la largeur de l'écran
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child:
                      Text('Mots clés', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor:
                        const Color.fromARGB(255, 125, 49, 74), // Fond rose
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
                        0), // 20% de la largeur de l'écran
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isBlue = index % 2 == 0;

                return buildCategory(
                  categories[index],
                  infos[index],
                  isBlue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(
      String category, List<Map<String, String>> infos, bool isBlue) {
    return Card(
      elevation: 2,
      color: isBlue ? Color.fromRGBO(105, 88, 95, 0.25) : Colors.white,
      child: ExpansionTile(
        title: Text('Category $category'),
        children: [
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: infos
                .map((info) => CardAnnuaire(
                      name: info['name'] ?? '',
                      email: info['email'] ?? '',
                      role: info['role'] ?? '',
                      imagePath: info['image'] ?? '',
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
