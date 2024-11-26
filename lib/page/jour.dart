import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bdd/bdd.dart';
import 'bdd/organisation.dart';
import 'package:comunique2024/page/page_details_event.dart';
import 'package:comunique2024/page/page_navigation.dart';


class DateDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE d MMMM ', 'fr_FR').format(now);
    
    return Text.rich(
      TextSpan(  
        children: [
          TextSpan(
            text: '$formattedDate ', // Jour de la semaine
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Gras
          ),
        ],
      ),
      );
  }
}

class JourView extends StatelessWidget {
  final Function(int) onPageChanged;
  final DateTime now = DateTime.now();
  
  JourView({required this.onPageChanged});

    Future<List<Map<String, dynamic>>> _fetchEventsForDay(DateTime day) async {
    final db = await AppDataBase.instance.database;
    final String dayString = DateFormat('yyyy-MM-dd').format(day);

    // Récupérer les événements pour le jour sélectionné
    final List<Map<String, dynamic>> maps = await db.query(
      'event',
      where: 'date = ?',
      whereArgs: [dayString],
    );

    List<Map<String, dynamic>> eventsWithColor = [];
    for (var eventMap in maps) {
      // Ajouter les informations de l'organisation
      final List<Map<String, dynamic>> orgaMaps = await db.query(
        'organisation',
        where: 'idOrga = ?',
        whereArgs: [eventMap['idOrganisation']],
      );
      final Organisation orga = Organisation.fromMap(orgaMaps.first);
      eventsWithColor.add({...eventMap, 'color': orga.color});
    }

    return eventsWithColor;
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
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => onPageChanged(0),
                child: Text('mois',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(width: 10), 


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(153, 100, 3, 42), 
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => onPageChanged(1),
                child: Text('semaine', style: TextStyle(color: Colors.white),),
              ),
              SizedBox(width: 10),
              
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 100, 3, 42),
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
               onPressed: () => onPageChanged(2),
                child: Text('jour',style: TextStyle(color: Colors.white),),
              ),


            ],
          ),
          SizedBox(height: 40),
          Center(
          child: DateDisplay(),
        ),
        SizedBox(height: 40),
          Divider(thickness: 1, color: Colors.grey), // Ligne de séparation
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchEventsForDay(now),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur: ${snapshot.error}"));
                }

                final events = snapshot.data ?? [];
                return _buildScheduleWithEvents(context, events);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleWithEvents(BuildContext context, List<Map<String, dynamic>> events) {
    // Convertir les heures de début et fin en objets `DateTime` pour les positions
    Map<int, List<Map<String, dynamic>>> eventsByHour = {};
    for (int hour = 8; hour < 24; hour++) {
      eventsByHour[hour] = [];
    }

    for (var event in events) {
      final startHour = int.parse(event['hDebut'].split(':')[0]);
      final endHour = int.parse(event['hFin'].split(':')[0]);
      
      for (int hour = startHour; hour < endHour; hour++) {
      eventsByHour[hour]?.add({...event, 'startHour': startHour});
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
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BasePage(currentIndex: 4, body:EventDetails(event: event)),
                                ),
                              );
                            },
                            child: Container(
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