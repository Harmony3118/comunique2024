import 'package:flutter/material.dart';

class creaGroupe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Nouveau groupe de diffusion " ),
      const Divider(
        thickness: 1,
        color: Colors.black,
      ),
      child: Text("Nom du groupe * " ),// à rajouter l'étoile comme un icon idealement 
      Container(  
                             // à verifier si fonctionne et mettre des bordures et des arrondis dans les coins  
        color: Colors.white,
        decoration: BoxDecoration(
          border: Border.all(
          color: Color.fromARGB(255, 100, 3, 42),
        )  
        child: Center(
          child: Container(
            width: 400,
            height: 50,              
            color: Colors.white30, 
          )      

      const Divider(
        thickness: 1,
        color: Color.fromARGB(255, 100, 3, 42),
        indent: 10, // reste a voir les valeurs quand je pourrai faire hotreload 
        endIndent: 10,
      child: Text("Participants * " ), // à rajouter l'étoile comme un icon idealement 
      //faire grosse boite avec icon loupe et TextEditingController avec TextField ou TextFormField 
      // faire un widget nom prenom idealement avec le icon qui est une pp puis le mettre sur deux rows 
      ),
      const Divider(  // par exemple on pourrai faire un class vue qu'on le reutilise 
        thickness: 1,
        color: Color.fromARGB(255, 100, 3, 42),
        indent: 10, // reste a voir les valeurs quand je pourrai faire hotreload 
        endIndent: 10, 
    )
      child: Text("Date de fin du groupe * " ),
      //rajouter icon calandrier 
      //avec une fonction similaire a celle de baptiste creation d'event qui permet de selectionner des dates 
    );
  }
}
