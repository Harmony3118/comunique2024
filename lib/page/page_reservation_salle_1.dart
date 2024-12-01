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
        height: 35,
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
              JourPicker(),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 400,
        height: 35,
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
        height: 35,
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
      _batimentExpansionTile("Bâtiment Ouest", Colors.grey[350]!, context),
      _batimentExpansionTile("Bâtiment Nord", Colors.white, context),
      _batimentExpansionTile("Bâtiment Sud", Colors.grey[350]!, context),
      _batimentExpansionTile("Bâtiment Est", Colors.white, context),
      const SizedBox(height: 20),
    ],
  );
}

Widget _batimentExpansionTile(String batimentName, Color color, BuildContext context) {
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
      children: <Widget>[
        ListTile(
          title: const Text(
            "Salle info",
            style: TextStyle(color: Color(0xFF640329)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp2(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text(
            "Salle maths",
            style: TextStyle(color: Color(0xFF640329)),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
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
            DateFormat.yMd().format(selectedDate),
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
        width: 100,
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