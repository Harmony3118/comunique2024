import 'package:comunique2024/page/bdd/utilisateur.dart';
import 'package:comunique2024/page/bdd/event.dart';

class Inscription {
  Event event;
  Utilisateur utilisateur;
  int nbPlaces;

  // Constructeur
  Inscription(
    this.event,
    this.utilisateur,
    this.nbPlaces,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idPost': event,
      'idUtilisateur': utilisateur,
      'nbPlaces': nbPlaces,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Inscription.fromMap(Map<String, dynamic> map) => Inscription(
        map['idPost'],
        map['idUtilisateur'],
        map['nbPlaces'],
      );
}
