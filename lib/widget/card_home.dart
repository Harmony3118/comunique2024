import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  final String office;
  final String role;
  final String eventTitle;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String imageUrl;
  final Color color;

  const CardHome({
    Key? key,
    required this.office,
    required this.role,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.imageUrl,
    required this.color,
  }) : super(key: key);

  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  bool isPinned = false;
  bool isRegistered = false;

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
                          backgroundImage: NetworkImage(widget.imageUrl),
                          radius: 25.0,
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
                        color: isPinned
                            ? const Color.fromRGBO(100, 3, 41, 1)
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPinned = !isPinned;
                        });
                      },
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
                  '${widget.eventDate}\n${widget.eventTime}\n${widget.eventLocation}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
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
