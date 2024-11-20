import 'dart:typed_data';

class Organisation {
  int? idOrga;
  String nom;
  Uint8List? imageData;
  int color;

  // Constructeur
  Organisation({
    this.idOrga,
    required this.nom,
    this.imageData,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': nom,
      'color': color,
    };
    if (imageData != null) {
      map['imageData'] = imageData;
    }
    return map;
  }

  // Pour créer une instance à partir d'un Map
  factory Organisation.fromMap(Map<String, dynamic> map) => Organisation(
        idOrga: map['idOrga'],
        nom: map['nom'],
        imageData: map['imageData'],
        color: map['color'],
      );
}
