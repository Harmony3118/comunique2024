import 'package:flutter/material.dart';

class WidgetBouton extends StatefulWidget {
  final String texte;
  final int forme;
  final int tailleHeight;
  final int tailleWidth;
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