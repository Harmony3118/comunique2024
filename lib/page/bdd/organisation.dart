class Organisation {
  int idOrga;
  String nom;

  // Constructeur
  Organisation({
    required this.idOrga,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'idOrga': idOrga,
      'nom': nom,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Organisation.fromMap(Map<String, dynamic> map) =>
      Organisation(idOrga: map['idOrga'], nom: map['nom']);
}
