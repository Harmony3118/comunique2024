class Organisation {
  int idOrga;
  String nom;
  // bool idBDE;
  // bool idBDS;
  // bool idBDA;
  // bool idJE;
  // bool idClub;
  // bool idAdmin;
  // bool idProfs;
  // bool idBinks;
  // bool idDoctorants;
  // bool idAlumnis;
  // bool idBdxInp;

  // Constructeur
  Organisation({
    required this.idOrga,
    required this.nom,
    // required this.idBDE,
    // required this.idBDS,
    // required this.idBDA,
    // required this.idJE,
    // required this.idClub,
    // required this.idAdmin,
    // required this.idProfs,
    // required this.idBinks,
    // required this.idDoctorants,
    // required this.idAlumnis,
    // required this.idBdxInp,
  });

  Map<String, dynamic> toMap() {
    return {
      'idOrga': idOrga,
      'nom': nom,
      // 'idBDE': idBDE,
      // 'idBDS': idBDS,
      // 'idBDA': idBDA,
      // 'idJE': idJE,
      // 'idClub': idClub,
      // 'idAdmin': idAdmin,
      // 'idProfs': idProfs,
      // 'idBinks': idBinks,
      // 'idDoctorants': idDoctorants,
      // 'idAlumnis': idAlumnis,
      // 'idBdxInp': idBdxInp,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Organisation.fromMap(Map<String, dynamic> map) =>
      Organisation(idOrga: map['idOrga'], nom: map['nom']);
}
