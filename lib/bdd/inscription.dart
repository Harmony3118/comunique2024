class Inscription {
  int idPost;
  int idUtilisateur;
  int nbPlaces;

  // Constructeur
  Inscription(
    this.idPost,
    this.idUtilisateur,
    this.nbPlaces,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idPost': idPost,
      'idUtilisateur': idUtilisateur,
      'nbPlaces': nbPlaces,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Inscription.fromMap(Map<String, dynamic> map) => Inscription(
        map['idPost'],
        map['idUtilisateur'],
        map['nbPlaces'],
      );
}
