import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/page_reservation2.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
      ),
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
                         currentIndex: 4, body: ContactPage())));
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
              Text(
                "Jour",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 160),
              JourTextField(),
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
              Text(
                "Heure début",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 8),
              Expanded(child: HeureTextField()),
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
              Text(
                "Heure fin",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              SizedBox(width: 40),
              Expanded(child: HeureTextField()),
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
        builder: (context) => (MyApp2()), 
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

class JourTextField extends StatelessWidget {
  const JourTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)), 
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)), 
          ),
          hintText: '',
          fillColor: Colors.grey[350],
          filled: true,
        ),
      ),
    );
  }
}

class HeureTextField extends StatelessWidget {
  const HeureTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF640329)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF640329)),
              ),
              hintText: '',
              fillColor: Colors.grey[350],
              filled: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          ':',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(width: 4),
        Container(
          width: 50,
          height: 35,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF640329)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF640329)),
              ),
              hintText: '',
              fillColor: Colors.grey[350],
              filled: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}



