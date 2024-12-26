import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_navigation.dart';

void main() {
  runApp(const MaterialApp(home: ReservationSallePage()));
}

String jour = '';
String heureDebut = '';
String heureFin = '';
String salle = '';

class ReservationSallePage extends StatefulWidget {
  const ReservationSallePage({super.key});

  @override
  _ReservationSallePageState createState() => _ReservationSallePageState();
}

class _ReservationSallePageState extends State<ReservationSallePage> {

  void naviguerPageSecondaire(String salleNom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AffichagePageSecondaire(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialisation des variables heureDebut et heureFin à l'heure actuelle
    DateTime now = DateTime.now();
    heureDebut = DateFormat("HH:mm").format(now);  // Format de l'heure
    heureFin = DateFormat("HH:mm").format(now);    // Format de l'heure
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AffichagePagePrincipale(),
    );
  }
}

// PAGE PRINCIPALE
class AffichagePagePrincipale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  fleche(context),
                  const SizedBox(width: 12),
                  Expanded(
                    child: reserver(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1, color: Colors.black),
            horaire(context),
            const SizedBox(height: 20),
            salledispo(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget reserver(BuildContext context) {
  return const Text(
    "Réserver une salle",
    style: TextStyle(
      color: Colors.black,
      fontSize: 21.78,
      fontWeight: FontWeight.w200,
    ),
    textAlign: TextAlign.center,
  );
}

Widget fleche(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios, size: 20.0),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BasePage(
            currentIndex: 2,
            body: ContactPage(),
          ),
        ),
      );
    },
  );
}

Widget horaire(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 400,
        height: 50,
        child: const Center(
          child: Text(
            "Tranches horaires",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(height: 50),
      Container(
        width: 400,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 10),
              const Text(
                "Jour",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              const SizedBox(width: 128),
              Expanded(
                child: JourPicker(),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 400,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 10),
              const Text(
                "Heure de début",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              const SizedBox(width: 26),
              Expanded(
                child: HeurePicker(
                  initialTime: heureDebut,  // Passer l'heure initiale
                  onTimeChanged: (value) {
                    heureDebut = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 400,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 10),
              const Text(
                "Heure de fin",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 21,
                ),
              ),
              const SizedBox(width: 56),
              Expanded(
                child: HeurePicker(
                  initialTime: heureFin,  // Passer l'heure initiale
                  onTimeChanged: (value) {
                    heureFin = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget salledispo(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 400,
        height: 50,
        child: const Center(
          child: Text(
            "Salles disponibles",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
          ),
        ),
      ),
      const SizedBox(height: 50),
      _batimentExpansionTile("Bâtiment Ouest", Colors.grey[350]!, context, [
        _salle("O108", "Amphithéâtre, avec vidéo-projecteur - 99 places (dont 16 strapontins) + 5 places pour PMR", Colors.orange, context),
        _salle("O201", "Salle visioconférence (accès restreint) - 15 places", Colors.orange, context),
        _salle("O202", "Salle informatique, avec vidéo-projecteur - 27 places", Colors.orange, context),
        _salle("O203", "Salle, avec vidéo-projecteur - 25 places", Colors.orange, context),
        _salle("O204", "Salle, avec vidéo-projecteur - 28 places", Colors.orange, context),
        _salle("O205", "Salle informatique, avec vidéo-projecteur - 27 places", Colors.orange, context),
        _salle("O207", "Salle avec vidéo-projecteur - 24 places", Colors.orange, context),
      ]),
      _batimentExpansionTile("Bâtiment Nord", Colors.white, context, [
        _salle("N103", "Amphithéâtre, avec équipement visio - 85 places avec tables (120 chaises)", Colors.blue[900]!, context),
        _salle("N201", "Salle du Conseil (accès restreint), salle avec vidéo-projecteur - 22 places", Colors.blue[900]!, context),
        _salle("N208", "Salle de formation continue (accès restreint), avec vidéo-projecteur - 21 places", Colors.blue[900]!, context),
      ]),
      _batimentExpansionTile("Bâtiment Sud", Colors.grey[350]!, context, [
        _salle("Bibliothèque", "14 places", Colors.red, context),
        _salle("S101", "Grande salle, avec vidéo-projecteur, modulable avec S103 - 102 places", Colors.red, context),
        _salle("S103", "Grande salle, avec vidéo-projecteur, modulable avec S101 - 80 places", Colors.red, context),
        _salle("S110", "Salle informatique, avec vidéo-projecteur - 25 places", Colors.red, context),
        _salle("S111", "Salle informatique, avec vidéo-projecteur – Accès 24/24 - 30 places", Colors.red, context),
        _salle("S112", "Salle informatique, avec vidéo-projecteur - 40 places", Colors.red, context),
      ]),
      _batimentExpansionTile("Bâtiment Est", Colors.white, context, [
        _salle("E101", "Laboratoire Human Monitoring & Laboratoire Handicap", Colors.green[900]!, context),
        _salle("E102", "Simulateur Airbus A320", Colors.green[900]!, context),
        _salle("E103", "Atelier avec imprimante 3D (interdit aux élèves)", Colors.green[900]!, context),
        _salle("E104", "Studio (accès au Club Photo)", Colors.green[900]!, context),
        _salle("E105", "Cobotique et Comportement", Colors.green[900]!, context),
        _salle("E106", "Simulateur voiture autonome", Colors.green[900]!, context),
        _salle("E107", "Laboratoire Human Monitoring et Laboratoire Handicap", Colors.green[900]!, context),
        _salle("E108", "Simulateur avion de combat", Colors.green[900]!, context),
        _salle("E204", "Méta Simu (7 postes équipés)", Colors.green[900]!, context),
        _salle("E206", "Régie", Colors.green[900]!, context),
      ]),
      const SizedBox(height: 20),
    ],
  );
}

Widget _batimentExpansionTile(String batimentName, Color color, BuildContext context, List<Widget> salles) {
  return Container(
    color: color,
    child: ExpansionTile(
      title: Text(
        batimentName,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 21,
        ),
      ),
      children: salles,
    ),
  );
}

Widget _salle(String nom, String description, Color color, BuildContext context) {
  return ListTile(
    title: Text(
      nom,
      style: TextStyle(color: color),
    ),
    subtitle: Text(description),
    onTap: () {
      salle = nom;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AffichagePageSecondaire(),
        ),
      );
    },
  );
}

class JourPicker extends StatefulWidget {
  const JourPicker({super.key});

  @override
  _JourPickerState createState() => _JourPickerState();
}

class _JourPickerState extends State<JourPicker> {
  DateTime selectedDate = DateTime.now();  // Initialisation avec la date actuelle

  @override
  void initState() {
    super.initState();
    jour = DateFormat("dd/MM/yyyy").format(selectedDate);  // Initialiser la variable jour avec la date du jour
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2080),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        jour = DateFormat("dd/MM/yyyy").format(selectedDate);  // Mettre à jour la variable jour
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF640329)),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[350],
        ),
        child: Center(
          child: Text(
            jour.isEmpty ? DateFormat("dd/MM/yyyy").format(selectedDate) : jour,  // Affichage de la date formatée
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class HeurePicker extends StatefulWidget {
  final Function(String) onTimeChanged;
  final String initialTime;

  const HeurePicker({super.key, required this.onTimeChanged, required this.initialTime});

  @override
  _HeurePickerState createState() => _HeurePickerState();
}

class _HeurePickerState extends State<HeurePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    // Initialiser selectedTime avec l'heure initiale
    final parts = widget.initialTime.split(":");
    selectedTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onTimeChanged(selectedTime.format(context));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF640329)),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[350],
        ),
        child: Center(
          child: Text(
            selectedTime.format(context),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

// PAGE SECONDAIRE
class AffichagePageSecondaire extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(salleNom: salle),
    );
  }
}

class Body extends StatefulWidget {
  final String salleNom;

  const Body({super.key, required this.salleNom});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Déclarez les contrôleurs pour chaque champ
  final TextEditingController objetController = TextEditingController();
  final TextEditingController pourQuiController = TextEditingController();
  final TextEditingController nombrePersonnesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      fleche(context),
                      const SizedBox(width: 10),
                      Expanded(
                        child: reserver(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(thickness: 2, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 20),
            reservation(context, widget.salleNom),
            const SizedBox(height: 20),
            envoyerButton(context, objetController, pourQuiController, nombrePersonnesController)
          ]
        ),
      ),
    );
  }

  // N'oubliez pas de libérer les contrôleurs pour éviter les fuites de mémoire
  @override
  void dispose() {
    objetController.dispose();
    pourQuiController.dispose();
    nombrePersonnesController.dispose();
    super.dispose();
  }

  Widget reservation(BuildContext context, String salleNom) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 50,
          child: Center(
            child: Text(
              salleNom,
              style: const TextStyle(
                color: Color(0xFF640329),
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildField("Objet de la réservation", JourTextField(controller: objetController)),
        const SizedBox(height: 10),
        _buildField("Pour qui", HeureTextField(controller: pourQuiController)),
        const SizedBox(height: 10),
        _buildField("Nombre de personnes", NombrePersonnesTextField(controller: nombrePersonnesController)),
      ],
    );
  }
}


Widget _buildField(String label, Widget textField) {
  return Container(
    width: 400,
    color: const Color.fromARGB(0, 255, 255, 255),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 4), // Espacement entre le texte et le champ
          textField,
        ],
      ),
    ),
  );
}

class NombrePersonnesTextField extends StatelessWidget {
  final TextEditingController controller;  // Ajoutez un champ pour le contrôleur

  const NombrePersonnesTextField({super.key, required this.controller});  // Modifiez le constructeur pour accepter le contrôleur

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: TextField(
        controller: controller,  // Passez le contrôleur ici
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Accepter uniquement les chiffres
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF640329)),
          ),
          hintText: '',
          fillColor: Colors.grey[350],
          filled: true,
        ),
      ),
    );
  }
}

class JourTextField extends StatelessWidget {
  final TextEditingController controller;

  const JourTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return _commonTextField(controller);
  }
}

class HeureTextField extends StatelessWidget {
  final TextEditingController controller;

  const HeureTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return _commonTextField(controller);
  }
}

Widget _commonTextField(TextEditingController controller) {
  return Container(
    width: 200,
    height: 50,
    child: TextField(
      controller: controller,  // Utilisez le contrôleur ici
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF640329)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF640329)),
        ),
        hintText: '',
        fillColor: Colors.grey[350],
        filled: true,
      ),
      keyboardType: TextInputType.text,
    ),
  );
}

Widget envoyerButton(BuildContext context, TextEditingController objetController, TextEditingController pourQuiController, TextEditingController nombrePersonnesController) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () async {
            const email = 'reservation-de-salle@ensc.fr';
            final objetReservation = objetController.text;
            final jourReservation = jour;
            final heureDebutReservation = heureDebut;
            final heureFinReservation = heureFin;
            final pourQui = pourQuiController.text;
            final nombrePersonnes = nombrePersonnesController.text;

            final body = '''
Bonjour, je sollicite votre attention pour effectuer une demande de réservation de salle.

DATE : $jourReservation
HORAIRES : de $heureDebutReservation à $heureFinReservation
MOTIF : $objetReservation
NOM de la PERSONNE effectuant la réservation : moi
NOM de la PERSONNE bénéficiaire de la réservation : $pourQui
SALLE : $salle
NOMBRE de personnes : $nombrePersonnes

Cordialement,
''';

            final encodedSubject = Uri.encodeComponent(objetReservation);
            final encodedBody = Uri.encodeComponent(body);

            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: email,
              query: 'subject=$encodedSubject&body=$encodedBody',
            );

            if (await canLaunchUrl(emailUri)) {
              await launchUrl(emailUri);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Impossible d\'ouvrir l\'application de messagerie.')),
              );
            }
          },
          child: const Text(
            'Envoyer un mail',
            style: TextStyle(
              color: Color(0xFF640329),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ),
  );
}