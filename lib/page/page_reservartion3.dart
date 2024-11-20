import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_navigation.dart';

void main() {
  runApp(const MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
         backgroundColor: Colors.white,
      body: Body()
    
      );
    
  }
}


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
     
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    fleche(context),
                    const SizedBox(width: 12),
                    Expanded(
                      child: reserver(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1, color: Colors.black),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: messageConfirmation(context),
              ),
            ],
          ),
        );
      
    
  }
}
Widget reserver(BuildContext context) {
  return const Center(  
    child: Text(
      "Réserver une salle",
      style: TextStyle(
        color: Colors.black,
        fontSize: 23,
        fontWeight: FontWeight.w200,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
Widget fleche(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios, size: 20.0),
    onPressed: () {
      Navigator.push(
               context,
                   MaterialPageRoute(
                       builder: (context) => BasePage(
                         currentIndex: 4, body: ContactPage())),);
    },
  );
}

Widget messageConfirmation(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFF640329), width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       const  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.check_circle, color: Colors.green, size: 30.0),
            SizedBox(width: 8),
            Text(
              "Réussi",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Vous avez bien envoyé une demande de réservation de la salle O205 pour le 13/11/2023 de 10h00 à 10h30.\n\n"
          "Votre réservation sera faite au nom du BDS, pour une réunion réunissant 8 personnes.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50), // Espacement avant le bouton
      ElevatedButton(
  onPressed: () {
    Navigator.push(
               context,
                   MaterialPageRoute(
                       builder: (context) => BasePage(
                         currentIndex: 4, body: ContactPage()))); // Action du bouton
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF640329), 
    // Taille du bouton
    minimumSize: const Size(20, 20), // Largeur: 250, Hauteur: 60
    // Forme du bouton (coins arrondis)
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0), // Rayon des coins arrondis
    ),

    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6.0),
  ),
  child: const Text(
    "Retour à l'accueil",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18, // Taille du texte
    ),
  ),
),


      ],
    ),
  );
}