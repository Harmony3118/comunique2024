class Role {
  // int? idPres;
  // int? idVicePres;
  // int? idSecretaire;
  // int? idMembre;
  // int? idTresorier;
  int idRole;
  String nomRole;

  // Constructeur
  Role({
    required this.idRole,
    required this.nomRole,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idRole': idRole,
      'nomRole': nomRole,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Role.fromMap(Map<String, dynamic> map) => Role(
        idRole: map['idRole'],
        nomRole: map['nomRole'],
      );
}
