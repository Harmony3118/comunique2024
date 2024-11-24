import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'semaine.dart';
import 'jour.dart';
import 'bdd/bdd.dart';
import 'bdd/event.dart';
import 'bdd/organisation.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/jourselection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// a toi de voir quel type de sortie tu veux
// void afficherPointEvents() async {
Future<List<Widget>> afficherPointEvents() async {
  final db = await AppDataBase.instance.database;
  // liste de tous les events qu'il faut afficher
  final List<Map<String, dynamic>> maps = await db.query('event');
  List<Event> evenements = List.generate(maps.length, (i) {
    return Event.fromMap(maps[i]);
  });
  List<Widget> newCards = []; // pas utile si type retour = void

  for (Event e in evenements) {
    List<Map<String, dynamic>> map1 = await db.query("Organisation",
        where: "idOrga = ?", whereArgs: [e.idOrganisation]);
    Organisation o = Organisation.fromMap(map1.first);

    // la couleur que tu dois afficher pour les events
    Color c = Color(o.color);

    // pour la date et l'heure des events
    String? date = e.date;
    String? heureDebut = e.hDebut;
    String? heureFin = e.hFin;

    // et la suite est pour toi
    // /!\ il faut que tu penses à tous les affichages
    // sur les trois types de calendrier
  }
  return newCards;
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // mettre le racourcis vers la base de données
  final List<Widget Function(Function(int))> _pages = [
    (onPageChanged) => MoisView(onPageChanged: onPageChanged),
    (onPageChanged) => SemaineView(onPageChanged: onPageChanged),
    (onPageChanged) => JourView(onPageChanged: onPageChanged),
  ];
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex](_onPageChanged),
    );
  }
}

class MoisView extends StatefulWidget {
  final Function(int) onPageChanged;

  MoisView({required this.onPageChanged});
  _MoisViewState createState() => _MoisViewState();
}

class _MoisViewState extends State<MoisView> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late Future<Map<DateTime, List<Color>>> _eventMarkers;

  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _eventMarkers = _fetchEventMarkers();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  setState(() {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
  });

  // Naviguer vers la page JourView avec la date sélectionnée
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BasePage(currentIndex:4,body:JourSelection(selectedDate: selectedDay),)
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<DateTime, List<Color>>>(
        future: _eventMarkers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final eventMarkers = snapshot.data ?? {};

          return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 100, 3, 42),
                    side: BorderSide(
                        color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(0),
                  child: Text(
                    'mois',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(153, 100, 3, 42),
                    side: BorderSide(
                        color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(1),
                  child: Text(
                    'semaine',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(153, 100, 3, 42),
                    side: BorderSide(
                        color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(2),
                  child: Text(
                    'jour',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            TableCalendar(
              locale: 'fr_FR',
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              
      ),
          ],
        ),
    );
        },
      ),
    );
  }
}


Future<Map<DateTime, List<Color>>> _fetchEventMarkers() async {
  final db = await AppDataBase.instance.database;
  final List<Map<String, dynamic>> events = await db.query('event');
  Map<DateTime, List<Color>> markers = {};

  for (var event in events) {
    DateTime eventDate = DateTime.parse(event['date']);
    final orgaResult = await db.query(
      'organisation',
      where: 'idOrga = ?',
      whereArgs: [event['idOrganisation']],
    );

    if (orgaResult.isNotEmpty) {
      Color color = Color(orgaResult.first['color'] as int);
      if (markers[eventDate] == null) {
        markers[eventDate] = [color];
      } else if (!markers[eventDate]!.contains(color)) {
        markers[eventDate]!.add(color);
      }
    }
  }

  print("Event markers: $markers"); 
  return markers;
}

// class EventPage extends StatelessWidget {
//   final DateTime selectedDay;

//   EventPage({required this.selectedDay});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 16.0), 
//           child: Center(
//             child: Text(
//               "évènements du .... ",
//               style: TextStyle(
//                 fontSize: 20, 
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Center(
//             child: FutureBuilder<List<Event>>(
//         future: fetchEventsForDay(selectedDay),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Erreur : ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Aucun événement pour ce jour."));
//           } else {
//             return ListView.builder( // a mettre la fonction pour bien afficher un event si possible
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final event = snapshot.data![index];
//                 return ListTile(
//                   title: Text(event.titre),
//                   subtitle: Text("${event.hDebut} - ${event.hFin}"),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       ),
//         ),
//       ],
//     ),
//     );
//   }

//   Future<List<Event>> fetchEventsForDay(DateTime day) async {
//     final db = await AppDataBase.instance.database;
//     final String dayString = "${day.year}-${day.month}-${day.day}";
//     final List<Map<String, dynamic>> maps = await db.query(
//       'event',
//       where: 'date = ?',
//       whereArgs: [dayString],
//     );
//     return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
//   }
// }

