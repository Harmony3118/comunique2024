// import 'package:comunique2024/page/page_file_actualite.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class CardHome extends StatefulWidget {
  final String office;
  final String role;
  final String eventTitle;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final Uint8List? imageData;
  final Color color;
  final String price;
  final String capacity;
  final String moreInfo;
  final bool isPinned; // Indique si l'événement est épinglé
  final VoidCallback onPinToggle; // Callback pour mettre à jour l'épingle

  const CardHome({
    Key? key,
    required this.office,
    required this.role,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    this.imageData,
    required this.color,
    required this.price,
    required this.capacity,
    required this.moreInfo,
    required this.isPinned,
    required this.onPinToggle,
  }) : super(key: key);

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  bool isPinned = false;
  bool isRegistered = false;
  bool isDetailled = false;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: widget.color, width: 2),
          ),
          title: const Text(
            "Êtes-vous sûr de vouloir vous inscrire ?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRegistered = true;
                });
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(widget.color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return widget.color;
                    }
                    return null;
                  },
                ),
              ),
              child: const Text(
                "S'inscrire",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: widget.color,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensures the avatar and text take up minimum space
                      children: [
                        CircleAvatar(
                          // backgroundImage: NetworkImage(widget.imageUrl),
                          radius: 25.0,
                          backgroundImage: widget.imageData != null
                              ? MemoryImage(widget.imageData as Uint8List)
                              : null,
                          // child: widget.imageData == null ? Text(${widget.office[0].toUpperCase()}${widget.office.split(' ')[1][0].toUpperCase()}',
                          // style: TextStyle(fontSize: 20.0, color: Colors.white),)
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text(
                            '${widget.office} - ${widget.role}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.push_pin,
                        color: widget.isPinned
                            ? const Color.fromRGBO(100, 3, 41, 1)
                            : Colors.grey,
                      ),
                      onPressed: widget.onPinToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.eventTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4.0),
                // This Text widget contains your event details which should be aligned to the left
                Text(
                  '${_formatDate(widget.eventDate)}\n${widget.eventTime}\n${widget.eventLocation}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(isDetailled
                    ? 'Prix : ${widget.price}\nNombres de places : ${widget.capacity}\n${widget.moreInfo}'
                    : ''),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isDetailled = !isDetailled;
                      });
                    },
                    child: Text(isDetailled
                        ? "- moins d'informations"
                        : "+ plus d'informations")),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: isRegistered ? null : _showConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.color,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(isRegistered ? "Inscrit" : "S'inscrire"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDate(String date) {
  // La chaîne de date est au format "yyyy-MM-dd"
  final parsedDate =
      DateTime.parse(date); // Convertit la chaîne en objet DateTime
  return '${_dayOfWeek(parsedDate.weekday)} ${parsedDate.day} ${_monthName(parsedDate.month)} ${parsedDate.year}';
}

String formatTimeInterval(String? startTime, String? endTime) {
  if (startTime != null && endTime != null) {
    return 'De ${_formatTime(startTime)} à ${_formatTime(endTime)}';
  } else if (startTime != null) {
    return 'Début : ${_formatTime(startTime)}';
  } else if (endTime != null) {
    return 'Fin : ${_formatTime(endTime)}';
  } else {
    return 'Horaire non défini';
  }
}

String _formatTime(String time) {
  // La chaîne d'heure est au format "HH:mm"
  print("time : ${time}");
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = parts[1];
  return '${hour}h$minute'; // Affiche "12h30" par exemple
}

String _dayOfWeek(int weekday) {
  const days = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];
  return days[weekday - 1]; // Les jours de la semaine en français
}

String _monthName(int month) {
  const months = [
    'janvier',
    'février',
    'mars',
    'avril',
    'mai',
    'juin',
    'juillet',
    'août',
    'septembre',
    'octobre',
    'novembre',
    'décembre'
  ];
  return months[month - 1]; // Les mois en français
}
