import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/widget/widget_bouton.dart';
import 'package:comunique2024/page/page_formulaire_event.dart';

class AjoutPage extends StatelessWidget {
  const AjoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Ajout", style: TextStyle(fontSize: 25)),
          Container(
            width: 289,
            height: 78,
            child: WidgetBouton(
              typeBouton: 1,
              texte: 'Créer un évènement',
              tailleText: 20,
              maFonction: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BasePage(currentIndex: 2, body: EventCreationForm()),
                    ));
              },
            ),
          ),
          Container(
            width: 289,
            height: 78,
            child: WidgetBouton(
              typeBouton: 1,
              texte: 'Créer un groupe',
              tailleText: 20,
              maFonction: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>
                //           BasePage(currentIndex: 2, body: EventCreationForm()),
                //    ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
