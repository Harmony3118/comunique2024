import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'semaine.dart';
import 'jour.dart';


 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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

  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay,) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; 
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
                  backgroundColor: Color.fromARGB(255, 100, 3, 42), 
                  side: BorderSide(color:Color.fromARGB(255, 100, 3, 42), width: 2),
                ),
                onPressed: () => widget.onPageChanged(0),
                child: Text('mois',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(width: 10), 


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(153, 100, 3, 42), 
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
          TableCalendar(
            locale:'fr_FR',
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
      ),
    );
  }
}


// class EventPage extends StatelessWidget {
//   final DateTime selectedDay;

//   EventPage({required this.selectedDay});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: event(),
//     );
//   }
// }

