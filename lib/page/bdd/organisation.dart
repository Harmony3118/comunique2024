class Organisation {
  bool idBDE;
  bool idBDS;
  bool idBDA;
  bool idJE;
  bool idClub;
  bool idAdmin;
  bool idProfs;
  bool idBinks;
  bool idDoctorants;
  bool idAlumnis;
  bool idBdxInp;

  // Constructeur
  Organisation({
    required this.idBDE,
    required this.idBDS,
    required this.idBDA,
    required this.idJE,
    required this.idClub,
    required this.idAdmin,
    required this.idProfs,
    required this.idBinks,
    required this.idDoctorants,
    required this.idAlumnis,
    required this.idBdxInp,
  });

  Map<String, dynamic> toMap() {
    return {
      'idBDE': idBDE,
      'idBDS': idBDS,
      'idBDA': idBDA,
      'idJE': idJE,
      'idClub': idClub,
      'idAdmin': idAdmin,
      'idProfs': idProfs,
      'idBinks': idBinks,
      'idDoctorants': idDoctorants,
      'idAlumnis': idAlumnis,
      'idBdxInp': idBdxInp,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Organisation.fromMap(Map<String, dynamic> map) => Organisation(
        idBDE: map['idBDE'] ?? false,
        idBDS: map['idBDS'] ?? false,
        idBDA: map['idBDA'] ?? false,
        idJE: map['idJE'] ?? false,
        idClub: map['idClub'] ?? false,
        idAdmin: map['idAdmin'] ?? false,
        idProfs: map['idProfs'] ?? false,
        idBinks: map['idBinks'] ?? false,
        idDoctorants: map['idDoctorants'] ?? false,
        idAlumnis: map['idAlumnis'] ?? false,
        idBdxInp: map['idBdxInp'] ?? false,
      );
}
