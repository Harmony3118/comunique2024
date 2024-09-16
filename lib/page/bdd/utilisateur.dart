class Utilisateur {
  int idEleve;
  String nom;
  String prenom;
  String email;
  int promotion;
  // photo ;

  // Constructeur avec des valeurs par défaut pour les paramètres facultatifs
  Utilisateur(
    this.idEleve,
    this.nom,
    this.prenom,
    this.email,
    this.promotion,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idEleve': idEleve,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'promotion': promotion,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Utilisateur.fromMap(Map<String, dynamic> map) => Utilisateur(
      map['idEleve'],
      map['nom'],
      map['prenom'],
      map['email'],
      map['promotion']);
}
