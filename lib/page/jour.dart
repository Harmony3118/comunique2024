import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



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
  

  JourView({required this.onPageChanged});


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