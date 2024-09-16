import 'package:flutter/material.dart';

class CardAnnuaire extends StatelessWidget {
  final String imagePath;
  final String name;
  final String role;
  final String email;

  const CardAnnuaire({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.role,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(2.0),
      child: Card(
        // Utilisez Material à la place de Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.transparent, // Rendre le Material transparent
        elevation: 0,
        child: Container(
          color: Colors.transparent, // Rendre le conteneur interne transparent
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Text(
                name,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                role,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 8,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 78, 21, 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
