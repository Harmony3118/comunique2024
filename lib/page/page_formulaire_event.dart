import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Importation du package file_picker pour sélectionner un fichier
import 'page_navigation.dart';
import 'page_file_actualite.dart'; // Importation de la page d'actualité
import 'bdd/event.dart';
import 'bdd/bdd.dart';

class EventCreationForm extends StatefulWidget {
  @override
  _EventCreationFormState createState() => _EventCreationFormState();
}

class _EventCreationFormState extends State<EventCreationForm> {
  final TextEditingController _expediteurController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _destinataireController = TextEditingController();
  final TextEditingController _objetController = TextEditingController();
  final TextEditingController _organisateurController = TextEditingController();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final TextEditingController _placesController = TextEditingController();
  final TextEditingController _infosComplementairesController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _inscriptionViaApp = false;
  bool _inscriptionViaHelloAsso = false;
  // on fera plus tard
  String? _selectedFile;

  @override
  void dispose() {
    // libère les controlleurs : qu'est ce que c'est ?
    _expediteurController.dispose();
    _roleController.dispose();
    _destinataireController.dispose();
    _objetController.dispose();
    _organisateurController.dispose();
    _titreController.dispose();
    _tarifController.dispose();
    _placesController.dispose();
    _infosComplementairesController.dispose();
    super.dispose();
  }

  // insérer un utilisateur
  void saveEvent() async {
    print("ok0");
    //if (formKey.currentState!.validate()) {
    print("ok1");
    // récupérer l'id de l'utilisateur
    // récupérer l'id du groupe
    // récupérer l'id du status (du role)
    final Event evenement = Event(
        idUtilisateur: 1,
        status: 1, // c'est le role
        idGroupe: 1,
        objet: _objetController.text,
        // organisateur ?
        titre: _titreController.text,
        // pb avec les types, comment faire la convertion ?
        date: _selectedDate.toString(),
        hDebut: _startTime.toString(),
        hFin: _endTime.toString(),
        lieu: "École", //-->  pas de choix du lieu dans le form
        tarif: double.parse(_tarifController.text),
        // nb de places
        commentaire: _infosComplementairesController.text,
        fichier: _selectedFile,
        inscription: _inscriptionViaApp);

    await AppDataBase.instance.insertEvent(evenement);

    // Affiche le message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Évènement ajouté !")),
    );

    // Réinitialiser les champs
    _expediteurController.clear();
    _roleController.clear();
    _destinataireController.clear();
    _objetController.clear();
    _organisateurController.clear();
    _titreController.clear();
    _tarifController.clear();
    _placesController.clear();
    _infosComplementairesController.clear();
    //}
  }

  // Fonction pour sélectionner une date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  // Fonction pour sélectionner une heure
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
  }

  Widget _buildInputRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              label + " *",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16, // Agrandit la taille du texte
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color.fromRGBO(155, 3, 63, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color.fromRGBO(155, 3, 63, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget titre avec ligne horizontale
  Widget _buildCenteredTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: const Color.fromRGBO(155, 3, 63, 1), fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }

  // Fonction pour sélectionner un fichier
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile =
            result.files.single.path; // Stocke le chemin du fichier sélectionné
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: const Color.fromRGBO(155, 3, 63, 1)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FileActualite()), // Redirection vers page_file_actualite.dart
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildCenteredTitle("Nouvelle publication"),
            _buildInputRow("Expéditeur", _expediteurController),
            _buildInputRow("Rôle", _roleController),
            _buildInputRow("Destinataire", _destinataireController),
            _buildInputRow("Objet", _objetController),
            Divider(),
            _buildCenteredTitle("Contenu"),
            _buildInputRow("Organisateur", _organisateurController),
            _buildInputRow("Titre de l'info", _titreController),
            // Choisir la date
            ListTile(
              title: Text(
                _selectedDate == null
                    ? 'Sélectionner une date'
                    : 'Date : ${_selectedDate!.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            // Heure de début
            ListTile(
              title: Text(
                _startTime == null
                    ? 'Sélectionner une heure de début'
                    : 'Heure de début : ${_startTime!.format(context)}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, true),
            ),
            // Heure de fin
            ListTile(
              title: Text(
                _endTime == null
                    ? 'Sélectionner une heure de fin'
                    : 'Heure de fin : ${_endTime!.format(context)}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context, false),
            ),
            Divider(),
            _buildCenteredTitle("Autres infos"),
            _buildInputRow("Tarif", _tarifController),
            _buildInputRow("Nombre de places", _placesController),
            Divider(),
            // Informations complémentaires
            TextField(
              controller: _infosComplementairesController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Informations complémentaires',
                hintText: 'Facultatif',
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color.fromRGBO(155, 3, 63, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color.fromRGBO(155, 3, 63, 1)),
                ),
              ),
            ),
            // Fichier
            ListTile(
              title: Text('Sélectionner un fichier'),
              trailing: Icon(Icons.attach_file),
              onTap:
                  _selectFile, // Appel de la fonction pour sélectionner un fichier
            ),
            if (_selectedFile !=
                null) // Afficher le chemin du fichier sélectionné
              Text('Fichier sélectionné : $_selectedFile'),
            Divider(),
            // Inscriptions
            CheckboxListTile(
              title: Text('Inscription via l\'appli'),
              value: _inscriptionViaApp,
              onChanged: (bool? value) {
                setState(() {
                  _inscriptionViaApp = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Inscription via Hello Asso'),
              value: _inscriptionViaHelloAsso,
              onChanged: (bool? value) {
                setState(() {
                  _inscriptionViaHelloAsso = value!;
                });
              },
            ),
            // Bouton Publier
            ElevatedButton(
              onPressed: () async {
                saveEvent();

                // test print
                final db = await AppDataBase.instance.database;
                List<Map<String, dynamic>> events = await db.query('event');
                print("Liste des évènements prévus");
                print(events);
                print("Fin de la liste");
                // fin test

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BasePage(currentIndex: 0, body: FileActualite()),
                    ));
              },
              child: Text('Publier'),
            ),
          ],
        ),
      ),
    );
  }
}
