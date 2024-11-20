import 'package:flutter/material.dart';
import 'page_navigation.dart';
import 'page_modifier_profil.dart';

class Pageparametre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centre verticalement le contenu
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Centre horizontalement le contenu
                      children: [
                        Text(
                          'Parametre',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Trait de séparation
                    Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                  ],
                ),
              ),
              // Section avec 4 boutons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment
                            .centerLeft, // Aligner à gauche  // Facultatif : ajout d'un peu de padding pour ne pas coller au bord
                        child: Text(
                          'Mon compte',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(1, 217, 217, 217),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BasePage(
                                      currentIndex: 0, body: ProfileEditForm()),
                                ));
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Texte à gauche de la flèche
                                const Text(
                                  'Mon profil', // Texte que vous voulez afficher
                                  style: TextStyle(
                                    color: Colors.black, // Couleur du texte
                                    fontSize: 16, // Taille du texte
                                  ),
                                ),
                                Spacer(), // Espacement entre le texte et la flèche
                                // Flèche entourée
                                Container(
                                  // Espacement autour de l'icône
                                  child: const Icon(
                                    Icons
                                        .arrow_circle_right_outlined, // Icône de la flèche
                                    color: Colors.black, // Couleur de l'icône
                                    size: 30, // Taille de l'icône
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(1, 217, 217, 217),
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Texte à gauche de la flèche
                                Text(
                                  'Mes infos épinglées', // Texte que vous voulez afficher
                                  style: TextStyle(
                                    color: Colors.black, // Couleur du texte
                                    fontSize: 16, // Taille du texte
                                  ),
                                ),
                                Spacer(), // Espacement entre le texte et la flèche
                                // Flèche entourée
                                Container(
                                  // Espacement autour de l'icône
                                  child: Icon(
                                    Icons
                                        .arrow_circle_right_outlined, // Icône de la flèche
                                    color: Colors.black, // Couleur de l'icône
                                    size: 30, // Taille de l'icône
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(1, 217, 217, 217),
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Texte à gauche de la flèche
                                Text(
                                  'Mes infos publiées', // Texte que vous voulez afficher
                                  style: TextStyle(
                                    color: Colors.black, // Couleur du texte
                                    fontSize: 16, // Taille du texte
                                  ),
                                ),
                                Spacer(), // Espacement entre le texte et la flèche
                                // Flèche entourée
                                Container(
                                  // Espacement autour de l'icône
                                  child: Icon(
                                    Icons
                                        .arrow_circle_right_outlined, // Icône de la flèche
                                    color: Colors.black, // Couleur de l'icône
                                    size: 30, // Taille de l'icône
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(1, 217, 217, 217),
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Texte à gauche de la flèche
                                Text(
                                  'Mes liens', // Texte que vous voulez afficher
                                  style: TextStyle(
                                    color: Colors.black, // Couleur du texte
                                    fontSize: 16, // Taille du texte
                                  ),
                                ),
                                Spacer(), // Espacement entre le texte et la flèche
                                // Flèche entourée
                                Container(
                                  // Espacement autour de l'icône
                                  child: Icon(
                                    Icons
                                        .arrow_circle_right_outlined, // Icône de la flèche
                                    color: Colors.black, // Couleur de l'icône
                                    size: 30, // Taille de l'icône
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Color.fromARGB(255, 51, 51, 51)),
              onPressed: () {
                Navigator.pop(context); // Retourner à la page précédente
              },
            ),
          ),
        ],
      ),
    );
  }
}
