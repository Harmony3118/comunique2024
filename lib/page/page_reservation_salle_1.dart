import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_reservation_salle_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
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
            horaire(context),
            const SizedBox(height: 20),
            salledispo(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget reserver(BuildContext context) {
  return const Text(
    "Réserver une salle",
    style: TextStyle(
      color: Colors.black,
      fontSize: 21.78,
      fontWeight: FontWeight.w200,
    ),
    textAlign: TextAlign.center,
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
            currentIndex: 2,
            body: ContactPage(),
          ),
        ),
      );
    },
  );
}

Widget horaire(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 400,
        height: 50,
        child: const Center(
          child: Text(
            "Tranches horaires",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(height: 50),
      Container(
        width: 400,
        height: 40,
        color: const Color.fromARGB(0, 255, 255, 255),
        child: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 10),
              Text(
                "Jour",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 128),
              Expanded(child: JourPicker()),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 400,
        height: 40,
        color: const Color.fromARGB(0, 255, 255, 255),
        child: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.access_time),
              SizedBox(width: 10),
              Text(
                "Heure de début",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 26),
              Expanded(child: HeurePicker()),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 400,
        height: 40,
        color: const Color.fromARGB(0, 255, 255, 255),
        child: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Icon(Icons.access_time),
              SizedBox(width: 10),
              Text(
                "Heure de fin",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 56),
              Expanded(child: HeurePicker()),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget salledispo(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 400,
        height: 50,
        child: const Center(
          child: Text(
            "Salles disponibles",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
          ),
        ),
      ),
      const SizedBox(height: 50),
      _batimentExpansionTile("Bâtiment Ouest", Colors.grey[350]!, context, [
        _salle("O108", "Amphithéâtre, avec vidéo-projecteur - 99 places (dont 16 strapontins) + 5 places pour PMR", Colors.orange, context),
        _salle("O201", "Salle visioconférence (accès restreint) - 15 places", Colors.orange, context),
        _salle("O202", "Salle informatique, avec vidéo-projecteur - 27 places", Colors.orange, context),
        _salle("O203", "Salle, avec vidéo-projecteur - 25 places", Colors.orange, context),
        _salle("O204", "Salle, avec vidéo-projecteur - 28 places", Colors.orange, context),
        _salle("O205", "Salle informatique, avec vidéo-projecteur - 27 places", Colors.orange, context),
        _salle("O207", "Salle avec vidéo-projecteur - 24 places", Colors.orange, context),
      ]),
      _batimentExpansionTile("Bâtiment Nord", Colors.white, context, [
        _salle("N103", "Amphithéâtre, avec équipement visio - 85 places avec tables (120 chaises)", Colors.blue[900]!, context),
        _salle("N201", "Salle du Conseil (accès restreint), salle avec vidéo-projecteur - 22 places", Colors.blue[900]!, context),
        _salle("N208", "Salle de formation continue (accès restreint), avec vidéo-projecteur - 21 places", Colors.blue[900]!, context),
      ]),
      _batimentExpansionTile("Bâtiment Sud", Colors.grey[350]!, context, [
        _salle("Bibliothèque", "14 places", Colors.red, context),
        _salle("S101", "Grande salle, avec vidéo-projecteur, modulable avec S103 - 102 places", Colors.red, context),
        _salle("S103", "Grande salle, avec vidéo-projecteur, modulable avec S101 - 80 places", Colors.red, context),
        _salle("S110", "Salle informatique, avec vidéo-projecteur - 25 places", Colors.red, context),
        _salle("S111", "Salle informatique, avec vidéo-projecteur – Accès 24/24 - 30 places", Colors.red, context),
        _salle("S112", "Salle informatique, avec vidéo-projecteur - 40 places", Colors.red, context),
      ]),
      _batimentExpansionTile("Bâtiment Est", Colors.white, context, [
        _salle("E101", "Laboratoire Human Monitoring & Laboratoire Handicap", Colors.green[900]!, context),
        _salle("E102", "Simulateur Airbus A 320", Colors.green[900]!, context),
        _salle("E103", "Atelier avec imprimante 3D (interdit aux élèves)", Colors.green[900]!, context),
        _salle("E104", "Studio (accès au Club Photo)", Colors.green[900]!, context),
        _salle("E105", "Cobotique et Comportement", Colors.green[900]!, context),
        _salle("E106", "Simulateur voiture autonome", Colors.green[900]!, context),
        _salle("E107", "Laboratoire Human Monitoring et Laboratoire Handicap", Colors.green[900]!, context),
        _salle("E108", "Simulateur avion de combat", Colors.green[900]!, context),
        _salle("E204", "Méta Simu (7 postes équipés)", Colors.green[900]!, context),
        _salle("E206", "Régie", Colors.green[900]!, context),
      ]),
      const SizedBox(height: 20),
    ],
  );
}

Widget _batimentExpansionTile(String batimentName, Color color, BuildContext context, List<Widget> salles) {
  return Container(
    color: color,
    child: ExpansionTile(
      title: Text(
        batimentName,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 21,
        ),
      ),
      children: salles,
    ),
  );
}

Widget _salle(String nom, String description, Color color, BuildContext context) {
  return ListTile(
    title: Text(
      nom,
      style: TextStyle(color: color),
    ),
    subtitle: Text(description),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp2(salleNom: nom),
        ),
      );
    },
  );
}

class JourPicker extends StatefulWidget {
  const JourPicker({super.key});

  @override
  _JourPickerState createState() => _JourPickerState();
}

class _JourPickerState extends State<JourPicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF640329)),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[350],
        ),
        child: Center(
          child: Text(
            DateFormat("dd/MM/yyyy").format(selectedDate),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class HeurePicker extends StatefulWidget {
  const HeurePicker({super.key});

  @override
  _HeurePickerState createState() => _HeurePickerState();
}

class _HeurePickerState extends State<HeurePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF640329)),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[350],
        ),
        child: Center(
          child: Text(
            selectedTime.format(context),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}