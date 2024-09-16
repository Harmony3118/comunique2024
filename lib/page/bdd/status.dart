class Status {
  int idEleve;
  int idOrganisation;
  int idRole;

  // Constructeur
  Status(
    this.idEleve,
    this.idOrganisation,
    this.idRole,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idEleve': idEleve,
      'idOrganisation': idOrganisation,
      'idRole': idRole,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Status.fromMap(Map<String, dynamic> map) => Status(
        map['idEleve'],
        map['idOrganisation'],
        map['idRole'],
      );
}
