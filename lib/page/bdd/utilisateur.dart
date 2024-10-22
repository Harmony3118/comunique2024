class Utilisateur {
  int idUtilisateur;
  String nom;
  String prenom;
  String email;
  int promotion;
  // photo ;

  // Constructeur avec des valeurs par défaut pour les paramètres facultatifs
  Utilisateur(
    this.idUtilisateur,
    this.nom,
    this.prenom,
    this.email,
    this.promotion,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idUtilisateur': idUtilisateur,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'promotion': promotion,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Utilisateur.fromMap(Map<String, dynamic> map) => Utilisateur(
      map['idUtilisateur'],
      map['nom'],
      map['prenom'],
      map['email'],
      map['promotion']);
}
