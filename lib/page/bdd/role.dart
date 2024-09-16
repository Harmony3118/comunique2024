class Role {
  int? idPres;
  int? idVicePres;
  int? idSecretaire;
  int? idMembre;
  int? idTresorier;

  // Constructeur
  Role({
    this.idPres,
    this.idVicePres,
    this.idSecretaire,
    this.idMembre,
    this.idTresorier,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idPres': idPres,
      'idVicePres': idVicePres,
      'idSecretaire': idSecretaire,
      'idMembre': idMembre,
      'idTresorier': idTresorier,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Role.fromMap(Map<String, dynamic> map) => Role(
        idPres: map['idPres'] ?? 0,
        idVicePres: map['idVicePres'] ?? 0,
        idSecretaire: map['idSecretaire'] ?? 0,
        idMembre: map['idMembre'] ?? 0,
        idTresorier: map['idTresorier'] ?? 0,
      );
}
