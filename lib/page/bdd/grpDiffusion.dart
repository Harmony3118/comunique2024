import 'package:comunique2024/page/bdd/utilisateur.dart';

class GrpDiffusion {
  int idGroupe;
  String? nom;
  List<Utilisateur>? membre;
  int? idOrganisation;

  // Constructeur
  GrpDiffusion({
    required this.idGroupe,
    this.nom,
    this.membre,
    this.idOrganisation,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idGroupe': idGroupe,
      'nom': nom,
      'membre': membre,
      'idOrganisation': idOrganisation,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory GrpDiffusion.fromMap(Map<String, dynamic> map) {
    return GrpDiffusion(
      idGroupe: map['idGroupe'],
      nom: map['nom'],
      membre: List<Utilisateur>.from(
          map['membre']?.map((x) => Utilisateur.fromMap(x))),
      idOrganisation: map['idOrganisation'],
      );
  }
}
