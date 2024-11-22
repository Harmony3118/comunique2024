import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:comunique2024/page/mois.dart';
import 'package:comunique2024/page/page_navigation.dart';
import 'package:comunique2024/page/jourselection.dart';


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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Afficher tous les horaires
                 
                  for (int hour = 8; hour < 24; hour++)  // Horaires de 8h à 18h
                    Row(
                      children: [
                        SizedBox(height: 40),
                        Text('$hour h 00', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Expanded(child: Divider(color: Colors.grey)), // Ligne de points
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
      ),
    );
  }
}