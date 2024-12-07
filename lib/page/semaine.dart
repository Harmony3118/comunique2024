import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/jourselection.dart';
import 'bdd/bdd.dart';
import 'package:intl/intl.dart';
import 'package:comunique2024/page/page_details_event.dart';

class SemaineView extends StatefulWidget {
  final Function(int) onPageChanged;
   
  SemaineView({required this.onPageChanged});
  
  @override
  _SemaineViewState createState() => _SemaineViewState();
}

class _SemaineViewState extends State<SemaineView> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now(); 
    _selectedDay = _focusedDay;
    _fetchEventsForWeek(_focusedDay);
  } 
   
Future<Map<int, Map<int, List<Map<String, dynamic>>>>> _organizeEventsByDay(
    List<Map<String, dynamic>> events) async {
  Map<int, Map<int, List<Map<String, dynamic>>>> eventsByDay = {};

  for (var event in events) {
    final eventDate = DateTime.parse(event['date']); // Assurez-vous que le champ 'date' existe.
    final dayOfWeek = eventDate.weekday - 1; // Convertit lundi = 1 en 0 (lundi).
    final startHour = event['hDebut'] != null
        ? int.tryParse(event['hDebut'].split(':')[0]) ?? 0
        : 0;
    final endHour = event['hFin'] != null
        ? int.tryParse(event['hFin'].split(':')[0]) ?? startHour
        : startHour;

    final eventColor = event['color'] ??
        const Color.fromARGB(255, 163, 12, 12).value; // Couleur par défaut.

    // Initialise la structure pour chaque jour et chaque heure
    eventsByDay.putIfAbsent(dayOfWeek, () => {});
    for (int hour = startHour; hour < endHour; hour++) {
      eventsByDay[dayOfWeek]!.putIfAbsent(hour, () => []);
      eventsByDay[dayOfWeek]![hour]!.add({
        ...event,
        'endHour': endHour,
        'startHour': startHour,
        'color': eventColor,
      });
    }
  }

  return eventsByDay;
}
  // Fonction pour obtenir les événements de la semaine
  Future<Map<int, Map<int, List<Map<String, dynamic>>>>> _fetchEventsForWeek(DateTime weekStart) async {
    final db = await AppDataBase.instance.database;
    final weekStartDate = weekStart.subtract(Duration(days: weekStart.weekday - 1)); // Lundi.
    final weekEndDate = weekStartDate.add(Duration(days: 6)); // Dimanche.

    final List<Map<String, dynamic>> events = await db.query(
      'event',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [
        DateFormat('yyyy-MM-dd').format(weekStartDate),
        DateFormat('yyyy-MM-dd').format(weekEndDate),
      ],
    );

    return await _organizeEventsByDay(events);
  }

  // Fonction pour changer de semaine (précédente ou suivante)
  void _changeWeek(int direction) {
    setState(() {
      _focusedDay = _focusedDay.add(Duration(days: direction * 7)); // Ajoute ou soustrait 7 jours pour changer de semaine
    });
    _fetchEventsForWeek(_focusedDay);  // Recharger les événements pour la nouvelle semaine
  }

  // Fonction qui gère la sélection du jour
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    // Naviguer vers la page JourView avec la date sélectionnée
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BasePage(currentIndex: 4, body: JourSelection(selectedDate: selectedDay)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(153, 100, 3, 42), 
                    side: BorderSide(color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(0),
                  child: Text('Mois', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 100, 3, 42),
                    side: BorderSide(color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(1),
                  child: Text('Semaine', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(153, 100, 3, 42),
                    side: BorderSide(color: Color.fromARGB(255, 100, 3, 42), width: 2),
                  ),
                  onPressed: () => widget.onPageChanged(2),
                  child: Text('Jour', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            // Ajout des flèches pour changer la semaine
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () => _changeWeek(-1), // Flèche gauche -> semaine précédente
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(_focusedDay), // Affiche la semaine en cours
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () => _changeWeek(1), // Flèche droite -> semaine suivante
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                locale: 'fr_FR',
                headerVisible: false,
                headerStyle: HeaderStyle(
                  formatButtonShowsNext: false,
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
            ),
            Divider(thickness: 1, color: Colors.grey), // Ligne de séparation
            FutureBuilder<Map<int, Map<int, List<Map<String, dynamic>>>>>(
              future: _fetchEventsForWeek(_focusedDay),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur: ${snapshot.error}"));
                }
                final eventsByDay = snapshot.data ?? {};
                return _buildScheduleWithEventsByDay(eventsByDay);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleWithEventsByDay(Map<int, Map<int, List<Map<String, dynamic>>>> eventsByDay) {
  return Column(
    children: [
      for (int hour = 8; hour < 24; hour++) // Pour chaque heure
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Première colonne : l'heure
            Container(
              width: 60, // Largeur fixe pour l'heure
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '$hour:00',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            // Colonnes pour les 7 jours
            for (int day = 0; day < 7; day++)
              Expanded(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: eventsByDay[day]?[hour] == null ||
                          eventsByDay[day]![hour]!.isEmpty
                      ? Divider(color: Colors.grey, thickness: 1)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var event in eventsByDay[day]![hour]!)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BasePage(
                                          currentIndex: 4,
                                          body: EventDetails(event: event),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2),
                                    decoration: BoxDecoration(
                                      color: Color(event['color']),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        event['titre'],
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
              ),
          ],
        ),
    ],
  );
}
}
