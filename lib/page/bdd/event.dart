class Event {
  int idPost;
  int idUtilisateur;
  int status;
  int idGroupe;
  String objet; //
  String titre; //
  String date;
  String hDebut;
  String hFin;
  String lieu;
  int tarif;
  String commentaire;
  String fichier;
  bool inscription;

  // Constructeur
  Event(
    this.idPost,
    this.idUtilisateur,
    this.status,
    this.idGroupe,
    this.objet,
    this.titre,
    this.date,
    this.hDebut,
    this.hFin,
    this.lieu,
    this.tarif,
    this.commentaire,
    this.fichier,
    this.inscription,
  );

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idPost': idPost,
      'idUtilisateur': idUtilisateur,
      'status': status,
      'idGroupe': idGroupe,
      'objet': objet,
      'titre': titre,
      'date': date,
      'hDebut': hDebut,
      'hFin': hFin,
      'lieu': lieu,
      'tarif': tarif,
      'commentaire': commentaire,
      'fichier': fichier,
      'inscription': inscription,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Event.fromMap(Map<String, dynamic> map) => Event(
      map['idPost'],
      map['idUtilisateur'],
      map['status'],
      map['idGroupe'],
      map['objet'],
      map['titre'],
      map['date'],
      map['hDebut'],
      map['hFin'],
      map['lieu'],
      map['tarif'],
      map['commentaire'],
      map['fichier'],
      map['inscription']);
}
