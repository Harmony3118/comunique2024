import 'dart:ffi';

import 'package:flutter/material.dart';

/*
class WidgetBouton extends StatefulWidget {
  final String texte;
  final int forme;
  final double tailleHeight;
  final double tailleWidth;
  const WidgetBouton({
    Key? key,
    required this.texte,
    required this.forme,
    required this.tailleHeight,
    required this.tailleWidth,
  }) : super(key: key);

  @override
  _WidgetBouton createState() => _WidgetBouton();
}

class _WidgetBouton extends State<WidgetBouton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: tailleWidth,
        height: tailleHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
            child: FilledButton(
                onPressed: forme,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(100, 3, 41, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: const Text(texte))));
  }
}

// backgroundColor: const Color.fromRGBO(100, 3, 41, 1),
// foregroundColor: Colors.white,
// backgroundColor: const Color.fromRGBO(100, 3, 41, 0.6),
// foregroundColor: Colors.white,
// backgroundColor: const Color.fromRGBO(215, 215, 215, 1),
// foregroundColor: Colors.black,

*/

class WidgetBouton extends StatelessWidget{
  final int typeBouton = 1;
  final String texte = "[Insérer Texte]";
  final Container?  contenu = Container(child: const Text('[Insérer Texte]'));
  // final MaterialPageRoute? page = null;
  final MaterialPageRoute? page = MaterialPageRoute(builder: (context) => ,);
  WidgetBouton({super.key})

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed:() {}, 
      child: Container(
        child: Text(
          texte, 
          style: TextStyle(
            color: 
          ),)),);
  }
}