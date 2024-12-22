class Utilisateur {
  int? id;
  String nom;
  String prenom;
  String email;
  String mdp;
  int promotion;
  // photo ;

  // Constructeur avec des valeurs par défaut pour les paramètres facultatifs
  Utilisateur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.mdp,
    required this.promotion,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'mdp': mdp,
      'promotion': promotion,
    };
  }

  // Pour créer une instance à partir d'un Map
  factory Utilisateur.fromMap(Map<String, dynamic> map) => Utilisateur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      mdp: map['mdp'],
      promotion: map['promotion']);
}
