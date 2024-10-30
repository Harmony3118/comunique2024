class Role {
  int? idRole;
  String nomRole;

  // Constructeur
  Role({
    this.idRole,
    required this.nomRole,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'nomRole': nomRole,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Role.fromMap(Map<String, dynamic> map) => Role(
        idRole: map['idRole'],
        nomRole: map['nomRole'],
      );
}
