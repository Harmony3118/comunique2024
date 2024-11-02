// import 'dart:ffi';

import 'package:flutter/material.dart';

class WidgetBouton extends StatelessWidget {
  const WidgetBouton(
      {Key? key,
      required this.typeBouton,
      required this.texte,
      required this.maFonction,
      required this.tailleText})
      : super(key: key);
  final int typeBouton;
  final String texte;
  final double tailleText;
  final void Function()? maFonction;
  static Color backgroundColor = const Color.fromRGBO(100, 3, 41, 1);
  static Color foregroundColor = Colors.white;

  void getCouleur() {
    if (typeBouton == 2) {
      backgroundColor = const Color.fromRGBO(215, 215, 215, 1);
      foregroundColor = Colors.black;
    } else if (typeBouton == 3) {
      backgroundColor = const Color.fromRGBO(100, 3, 41, 0.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCouleur();
    return ElevatedButton(
      onPressed: maFonction,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(
        texte,
        style: TextStyle(fontSize: tailleText),
      ),
    );
  }
}
