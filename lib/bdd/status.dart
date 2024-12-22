class Status {
  int idUtilisateur;
  int idOrganisation;
  int idRole;
  int annee;

  // Constructeur
  Status(
    this.idUtilisateur,
    this.idOrganisation,
    this.idRole,
    this.annee,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idUtilisateur': idUtilisateur,
      'idOrganisation': idOrganisation,
      'idRole': idRole,
      'annee': annee,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Status.fromMap(Map<String, dynamic> map) => Status(
        map['idUtilisateur'],
        map['idOrganisation'],
        map['idRole'],
        map['annee'],
      );
}
