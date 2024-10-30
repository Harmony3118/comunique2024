import 'package:flutter/material.dart';

class CreaGroupe extends StatelessWidget {  //j'ai changé a statefull pour pouvoir utiliser la class _LesInfosDesText
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children:[
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                 ),
            
                const Text(
                  "Nouveau groupe de diffusion",
                  style: TextStyle(fontSize: 14),
                  //FontWeight(400),
                ),
              ],
            ),
         
            // faire un truc pour que quand on appui dessus ca nous envoie en arrière

            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const Text("Nom du groupe *",
            style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
            ), // Astérisque

            // Conteneur avec bordures et arrondis
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 100, 3, 42),
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Container(
                  width: 400,
                  height: 40,
                  color: Colors.white30,
                ),
              ),
            ),
            ),

            // Divider pour séparer les sections
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 100, 3, 42),
              indent: 50,
              endIndent: 50,
            ),
            const Text("Participants *",
              style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
            ), // Asterisk

            // Champ de recherche avec TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 40,
                child: TextField(    
   //             controller: _controller,           
                decoration: InputDecoration(
                //  contentPadding: EdgeInsets.symmetric(vertical: 0.5),  utiliser methode avec container à la place
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 100, 3, 42), // Border color
                      width: 2.0, // Thickness of the border
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                    color: Color.fromARGB(255, 100, 3, 42), // Border color
                    width: 2.0, // Thickness of the border
                    ),
                    borderRadius: BorderRadius.circular(10.0),                  
                  ),
                  
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 100, 3, 42),
                  ),
                  labelText: "Rechercher",
                  filled: true,
                  fillColor:const Color(0xFFD9D9D9),
                ),
              
              ),
              ),
             
              
            ),

            // Divider pour séparer les sections
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 100, 3, 42),
              indent: 50,
              endIndent: 50,
            ),
            const Text("Date de fin du groupe *"),

            // Ajouter un bouton ou un widget pour sélectionner une date
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Ajouter la fonction pour choisir une date
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text("Sélectionner une date"),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.white,
                  foregroundColor: const Color.fromARGB(255, 100, 3, 42),
                  side: const BorderSide(color: Color.fromARGB(255, 100, 3, 42)),
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}


//les deux dernier divider plutot faire une class a part avec un container avec bout arrondis à la place


//class _LesInfosDesText extends State<CreaGroupe> {
  // Step 1: Initialize a TextEditingController
 // final TextEditingController _controller = TextEditingController();
//}