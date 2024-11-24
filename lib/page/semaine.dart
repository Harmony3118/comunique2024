import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:comunique2024/page/mois.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/jourselection.dart';
import 'bdd/bdd.dart';
import 'bdd/event.dart';
import 'bdd/organisation.dart';
import 'package:intl/intl.dart';


class SemaineView extends StatefulWidget {
  final Function(int) onPageChanged;

  SemaineView({required this.onPageChanged});
  @override
  _SemaineViewState createState() => _SemaineViewState();
}

class _SemaineViewState extends State<SemaineView> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;


  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now(); 
    _selectedDay = _focusedDay;
    _fetchEventsForWeek(_focusedDay);
  } 
  
// Charger les événements de la semaine
  Future<List<Map<String, dynamic>>> _fetchEventsForWeek(DateTime weekStart) async {
  final db = await AppDataBase.instance.database;
  final weekStartDate = weekStart.subtract(Duration(days: weekStart.weekday - 1)); // Lundi
  final weekEndDate = weekStartDate.add(Duration(days: 6)); // Dimanche

  final List<Map<String, dynamic>> events = await db.query(
    'event',
    where: 'date BETWEEN ? AND ?',
    whereArgs: [
      DateFormat('yyyy-MM-dd').format(weekStartDate),
      DateFormat('yyyy-MM-dd').format(weekEndDate),
    ],
  );

  return events; // Retourne directement les événements
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
      builder: (context) => BasePage(currentIndex:4,body:JourSelection(selectedDate: selectedDay),
    )),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column( 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(153, 100, 3, 42), 
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => widget.onPageChanged(0),
                child: Text('mois',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(width: 10), 


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 100, 3, 42), 
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => widget.onPageChanged(1),
                child: Text('semaine', style: TextStyle(color: Colors.white),),
              ),
              SizedBox(width: 10),
              
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(153, 100, 3, 42),
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => widget.onPageChanged(2),
                child: Text('jour',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: TableCalendar(
            calendarFormat: CalendarFormat.week,
            locale:'fr_FR',
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


          FutureBuilder<List<Map<String, dynamic>>>(
  future: _fetchEventsForWeek(_focusedDay), // Appel avec _focusedDay
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text("Erreur: ${snapshot.error}"));
    }

    final events = snapshot.data ?? [];
    return _buildScheduleWithEvents(events);
  },
),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleWithEvents(List<Map<String, dynamic>> events) {
    // Convertir les heures de début et fin en objets `DateTime` pour les positions
    Map<int, List<Map<String, dynamic>>> eventsByHour = {};
    for (int hour = 8; hour < 24; hour++) {
      eventsByHour[hour] = [];
    }

    for (var event in events) {
  // Vérifications pour chaque champ
  final startHour = event['hDebut'] != null
      ? int.tryParse(event['hDebut'].split(':')[0]) ?? 0
      : 0;
  final endHour = event['hFin'] != null
      ? int.tryParse(event['hFin'].split(':')[0]) ?? startHour
      : startHour;

  final eventColor = event['color'] != null
      ? event['color']
      : const Color.fromARGB(255, 163, 12, 12).value; // Couleur par défaut
 
  // Ajout des événements dans la carte des heures
  for (int hour = startHour; hour < endHour; hour++) {
    eventsByHour[hour]?.add({
      ...event, 
      'startHour': startHour,
      'color': eventColor, // Ajoute une couleur par défaut si nécessaire
    });
  }
}


return Column(
    children: [
      for (int hour = 8; hour < 24; hour++) // Horaires de 8h à 23h
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horaires affichés en premier
            Column(
              children: [
                Text('$hour h 00', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16), // Ajoute de l'espace sous l'heure
              ],
            ),
            SizedBox(width: 8), // Espacement entre l'heure et les événements
            // Trait de séparation ou événements
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (eventsByHour[hour] == null ||
                      eventsByHour[hour]!.isEmpty)
                    // Ligne si aucun événement
                  Expanded(child: Divider(color: Colors.grey))
                  else
                    // Afficher les événements pour cette heure
                    for (var event in eventsByHour[hour]!)
                      if (event['startHour'] == hour)
                       // Afficher à l'heure de début
                       Expanded(
                         child:
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(event['color']),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            event['titre'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                       ),
                    
                ],
              ),
            ),
          ],
        ),
        ],
      );
  }
}