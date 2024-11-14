import 'package:comunique2024/page/bdd/organisation.dart';
import 'package:flutter/material.dart';
import 'package:comunique2024/widget/filter_homeScreen.dart';
import 'package:comunique2024/widget/card_home.dart';
import 'bdd/event.dart';
import 'bdd/role.dart';
import 'bdd/bdd.dart';

class FileActualite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Filter(),
          ),
          Expanded(
            child: ListView(
              children: const [
                CardHome(
                  office: "JE",
                  role: "Présidente i2c",
                  eventTitle: 'Formation i2c',
                  eventDate: 'Le jeudi 16 novembre 2023',
                  eventTime: 'De 12h30 à 14h',
                  eventLocation: 'Salle S103',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(187, 208, 143, 0.71),
                ),
                CardHome(
                  office: "BDS",
                  role: "Respo WES",
                  eventTitle: 'WES',
                  eventDate: 'Du 12 au 14 janvier 2024',
                  eventTime: '',
                  eventLocation: 'Station Pas de la Case, Andorre',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(167, 222, 219, 0.71),
                ),
                CardHome(
                  office: "BDA",
                  role: "Club musique",
                  eventTitle: 'Répétition',
                  eventDate: 'Le mardi 21 septembre 2023',
                  eventTime: 'De 12h30 à 13h30',
                  eventLocation: 'Salle S103',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(245, 233, 171, 0.71),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


      // informations de e : 
          // e.commentaire
          // e.date
          // e.fichier
          // e.hDebut
          // e.hFin
          // e.idGroupe
          // e.idPost
          // e.idUtilisateur
          // e.idOrganisation   vv
          // e.inscription
          // e.lieu
          // e.objet
          // e.tarif
          // e.status           vv
          // e.titre            vv
          //
          // what about organisateur ?
  void afficherListEvents() async {
    final db = await AppDataBase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('utilisateur');
    List<Event> evenements = List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });

    for(Event e in evenements) {
      List<Map<String, dynamic>> map1 = await db.query("Organisation", where: "idOrga = ?", whereArgs: [e.idOrganisation]);
      Organisation o = Organisation.fromMap(map1[1]);
      List<Map<String, dynamic>> map2 = await db.query("role", where: "idRole = ?", whereArgs: [e.status]);
      Role r = Role.fromMap(map2[1]);
      CardHome(
        office: o.nom,
        role: r.nomRole,
        eventTitle: e.titre,
        //eventDate: 'Le jeudi 16 novembre 2023',
        eventDate: e.date,
        eventTime: 'De${e.hDebut} à ${e.hFin}',
        eventLocation: e.lieu,
        imageData: o.imageData,
        color: Color.fromRGBO(187, 208, 143, 0.71),
      ),
    }
  }
}
