import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_form_absence.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_reservation_salle.dart';
import 'package:comunique2024/page/page_form_soiree.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Contacter l'administration",
              style: TextStyle(fontSize: 25)),
          Container(
              width: 289,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color.fromARGB(255, 100, 3, 42),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BasePage(currentIndex: 4, body: Absence()),
                      ));
                },
                child: const Text(
                  'Justifier une absence',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
          Container(
              width: 289,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color.fromARGB(255, 100, 3, 42),
              ),
              child: TextButton(
                onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BasePage(currentIndex: 4, body: ReservationSallePage()),
                      ));},
                child: const Text(
                  'Réserver une salle',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
          Container(
              width: 289,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color.fromARGB(255, 100, 3, 42),
              ),
                            child: TextButton(
                onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BasePage(currentIndex: 4, body: FormSoiree()),
                      ));},
                child: const Text(
                  'Organiser un événement',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
        ]),
      ),
    );
  }
}