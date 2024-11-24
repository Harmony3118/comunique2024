import 'package:flutter/material.dart';
import 'package:comunique2024/widget/card_home.dart';
import 'bdd/utilisateur.dart';

class EventDetails extends StatefulWidget {
  final Map<String, dynamic> event;

  EventDetails({required this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Utilisateur? utilisateur;  // Déclarez une variable pour stocker l'utilisateur connecté

  @override
  void initState() {
    super.initState();
  }

  // Récupérer l'utilisateur connecté
//   void _loadUtilisateur() async {
//     final user = await getUtilisateurConnecte();  // Appeler la méthode pour récupérer l'utilisateur
//     setState(() {
//       utilisateur = user;  // Mettez à jour l'état avec l'utilisateur récupéré
//     });
//   }
//   Future<Utilisateur?> getUtilisateurConnecte() async {
//   final db = await AppDataBase.instance.database;
  
//   // Suppose que vous avez une table utilisateur et que vous souhaitez récupérer l'utilisateur avec un ID spécifique ou un autre critère.
//   List<Map<String, dynamic>> maps = await db.query('utilisateur', where: 'idUtilisateur = ?', whereArgs: [1]);

//   if (maps.isNotEmpty) {
//     return Utilisateur.fromMap(maps.first);
//   }
//   return null;
// }
  @override
  Widget build(BuildContext context) {
    // if (utilisateur == null) {
    //   // Si l'utilisateur n'est pas encore chargé, afficher un indicateur de chargement
    //   return Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // Lorsque l'utilisateur est chargé, afficher les détails de l'événement
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
          children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 51, 51, 51)),
                  onPressed: () {
                    Navigator.pop(context); // Retourner à la page précédente
                  },
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                "Détail de l'évènement ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Expanded(  
            child: Center(
              // Afficher l'événement avec l'utilisateur connecté
              child: CardHome(
                office: widget.event['office'] ?? "Bureau inconnu",
                role: widget.event['role'] ?? "Rôle inconnu",
                object: widget.event['object'] ?? "Rôle inconnu",
          eventTitle: widget.event['titre'] ?? "Titre inconnu",
                eventDate: widget.event['date'] ?? "Date inconnue",
                eventTime: formatTimeInterval(widget.event['hDebut'], widget.event['hFin']),
                eventLocation: widget.event['location'] ?? "Lieu inconnu",
                imageData: widget.event['imageData'],  // Si vous avez une image, sinon mettez null
                color: Color(widget.event['color']),
                price: widget.event['price'] ?? 0.0,
                moreInfo: widget.event['moreInfo'] ?? "Aucune information supplémentaire",
                isPinned: widget.event['isPinned'] ?? false,
                onPinToggle: () {
                },  
              ),
            ),
          ),
        ],
      ),
    );
  }
}
