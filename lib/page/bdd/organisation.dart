import 'dart:typed_data';

class Organisation {
  int? idOrga;
  String nom;
  Uint8List? imageData;

  // Constructeur
  Organisation({
    this.idOrga,
    required this.nom,
    this.imageData,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': nom,
    };
    if (imageData != null) {
      map = {
        'nom': nom,
        'imageData': imageData,
      };
    }
    return map;
  }

  // Pour créer une instance à partir d'un Map
  factory Organisation.fromMap(Map<String, dynamic> map) => Organisation(
      idOrga: map['idOrga'], nom: map['nom'], imageData: map['imageData']);
}
