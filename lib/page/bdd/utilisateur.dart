class Utilisateur {
  int? idUtilisateur;
  String nom;
  String prenom;
  String email;
  int promotion;
  // photo ;

  // Constructeur avec des valeurs par défaut pour les paramètres facultatifs
  Utilisateur({
    this.idUtilisateur,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.promotion,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'promotion': promotion,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Utilisateur.fromMap(Map<String, dynamic> map) => Utilisateur(
      idUtilisateur: map['idUtilisateur'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      promotion: map['promotion']);
}
