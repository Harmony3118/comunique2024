class Event {
  int? idPost;
  int idUtilisateur;
  int idOrganisation;
  int status; // = role
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
  int inscriptionAppli; // ce sont des booléens mais conservés en int
  int inscriptionHelloAsso; // ce sont des booléens mais conservés en int

  // Constructeur
  Event({
    this.idPost,
    required this.idUtilisateur,
    required this.idOrganisation,
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
    required this.inscriptionAppli,
    required this.inscriptionHelloAsso,
  });

  // Méthode pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'idUtilisateur': idUtilisateur,
      'idOrganisation': idOrganisation,
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
      'inscriptionAppli': inscriptionAppli,
      'inscriptionHelloAsso': inscriptionHelloAsso,
    };
  }

  //Pour créer une instance à partir d'un Map
  factory Event.fromMap(Map<String, dynamic> map) => Event(
      idPost: map['idPost'],
      idUtilisateur: map['idUtilisateur'],
      idOrganisation: map['idOrganisation'],
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
      inscriptionAppli: map['inscriptionAppli'],
      inscriptionHelloAsso: map['inscriptionHelloAsso']);
}
