import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:flutter/src/material/divider.dart';
import 'package:flutter/src/widgets/framework.dart';


class creaGroupe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (
        child: Text("Nouveau groupe de diffusion " ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        child: Text("Nom du groupe * " ),// pas trouvé d'icon astérix
        Container(  
                   // à verifier si fonctionne  
          color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              upperLeft: Radius.circular(10.0),              
              upperRight: Radius.circular(10.0),             
            ),
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
        TextField(
        decoration:BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              upperLeft: Radius.circular(10.0),              
              upperRight: Radius.circular(10.0), 
              child :Icon(   // il faut reussir à la placer a droite de la boite 
                Icons.search,
                size: 100,
                color: Colors.fromARGB(255, 100, 3, 42),)
            labelText: "I"  ,
            border: Border.all(
            color: Color.fromARGB(255, 100, 3, 42),
              )             
            ),
        )
        // faire un widget nom prenom avec le icon qui est une pp inspiré de l'annuaire 
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
        )
    );
  }
}

