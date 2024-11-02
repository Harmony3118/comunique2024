class Event {
  int? idPost;
  int idUtilisateur;
  int status;
  int idGroupe;
  String objet; //
  String titre; //
  String date;
  String hDebut;
  String hFin;
  String lieu;
  double tarif; // changer le type dans la bdd
  String commentaire;
  String? fichier;
  bool inscription;

  // Constructeur
  Event({
    this.idPost,
    required this.idUtilisateur,
    required this.status,
    required this.idGroupe,
    required this.objet,
    required this.titre,
    required this.date,
    required this.hDebut,
    required this.hFin,
    required this.lieu,
    required this.tarif,
    required this.commentaire,
    this.fichier,
    required this.inscription,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
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
      idPost: map['idPost'],
      idUtilisateur: map['idUtilisateur'],
      status: map['status'],
      idGroupe: map['idGroupe'],
      objet: map['objet'],
      titre: map['titre'],
      date: map['date'],
      hDebut: map['hDebut'],
      hFin: map['hFin'],
      lieu: map['lieu'],
      tarif: map['tarif'],
      commentaire: map['commentaire'],
      fichier: map['fichier'],
      inscription: map['inscription']);
}
