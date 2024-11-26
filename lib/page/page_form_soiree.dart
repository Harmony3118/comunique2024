import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormSoiree extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class VerifSoiree extends StatelessWidget {
  final TextEditingController titreController;
  final TextEditingController dateController;
  final TextEditingController timeStartController;
  final TextEditingController salleController;
  final TextEditingController dureeNettoyageController;
  final TextEditingController affluenceAttendueController;
  final TextEditingController publicViseController;
  final bool personnesExterieures;
  final bool presenceVigile;
  final TextEditingController nombrePersonnesController;
  final TextEditingController typeBoissonController;
  final TextEditingController quantiteBoissonController;
  final TextEditingController equipeDistributionController;
  final TextEditingController responsableEvenementController;
  final TextEditingController telephoneResponsableController;
  final TextEditingController entiteOrganisatriceController;
  final TextEditingController referentBDEController;
  final TextEditingController telephoneReferentController;
  final TextEditingController responsableVSSController;
  final TextEditingController lieuxSafePlaceController;

  VerifSoiree({
    required this.titreController,
    required this.dateController,
    required this.timeStartController,
    required this.salleController,
    required this.dureeNettoyageController,
    required this.affluenceAttendueController,
    required this.publicViseController,
    required this.personnesExterieures,
    required this.presenceVigile,
    required this.nombrePersonnesController,
    required this.typeBoissonController,
    required this.quantiteBoissonController,
    required this.equipeDistributionController,
    required this.responsableEvenementController,
    required this.telephoneResponsableController,
    required this.entiteOrganisatriceController,
    required this.referentBDEController,
    required this.telephoneReferentController,
    required this.responsableVSSController,
    required this.lieuxSafePlaceController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Inter', color: Colors.black),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Vérification de la soirée',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 319.0,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 100, 3, 42),
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Résumé de la soirée",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                    TextSpan(
                                        text:
                                            "Titre : ${titreController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Date : ${dateController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Heure de début : ${timeStartController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Salle : ${salleController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Durée de nettoyage : ${dureeNettoyageController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Affluence attendue : ${affluenceAttendueController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Public visé : ${publicViseController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Personnes extérieures : ${personnesExterieures ? "Oui" : "Non"}\n\n"),
                                    TextSpan(
                                        text:
                                            "Présence de vigiles : ${presenceVigile ? "Oui" : "Non"}\n\n"),
                                    TextSpan(
                                        text:
                                            "Nombre total de personnes : ${nombrePersonnesController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Type de boisson : ${typeBoissonController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Quantité de boisson : ${quantiteBoissonController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Équipe de distribution : ${equipeDistributionController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Responsable de l'événement : ${responsableEvenementController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Téléphone du responsable : ${telephoneResponsableController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Entité organisatrice : ${entiteOrganisatriceController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Référent BDE : ${referentBDEController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Téléphone du référent : ${telephoneReferentController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Responsable VSS : ${responsableVSSController.text}\n\n"),
                                    TextSpan(
                                        text:
                                            "Lieux Safe Place : ${lieuxSafePlaceController.text}\n\n"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 215, 215, 215),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Modifier',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 100, 3, 42),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmationSoiree(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Confirmer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationSoiree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Retour au formulaire précédent
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Confirmation',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Inter', color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 100, 3, 42),
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Message Icon and Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_circle_outline,
                        color: Color.fromARGB(255, 15, 169, 88),
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Réussi",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Votre demande d'organisation a été envoyée avec succès.\nUn retour vous sera fait prochainement.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  // Back to Home Button
                  Container(
                    width: 176,
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: const Color.fromARGB(255, 100, 3, 42),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text(
                        "Retour à l'accueil",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EventFormState extends State<FormSoiree> {
  final _formKey = GlobalKey<FormState>();

  // Détails (partie)
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _salleController = TextEditingController();
  final TextEditingController _dureeNettoyageController =
      TextEditingController();

  // Public visé et sécurité (partie)
  final TextEditingController _affluenceAttendueController =
      TextEditingController();
  final TextEditingController _publicViseController = TextEditingController();
  bool _personnesExterieuresOui = false;
  bool _personnesExterieuresNon = true;
  bool _presenceVigileOui = false;
  bool _presenceVigileNon = true;
  final TextEditingController _nombrePersonnesController =
      TextEditingController();

  // Boisson (partie)
  final TextEditingController _typeBoissonController = TextEditingController();
  final TextEditingController _quantiteBoissonController =
      TextEditingController();
  final TextEditingController _equipeDistributionController =
      TextEditingController();

  // Équipe organisatrice (partie)
  final TextEditingController _responsableEvenementController =
      TextEditingController();
  final TextEditingController _telephoneResponsableController =
      TextEditingController();
  final TextEditingController _entiteOrganisatriceController =
      TextEditingController();
  final TextEditingController _referentBDEController = TextEditingController();
  final TextEditingController _telephoneReferentController =
      TextEditingController();

  // Lutte VSS (partie)
  final TextEditingController _responsableVSSController =
      TextEditingController();
  final TextEditingController _lieuxSafePlaceController =
      TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateController) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _timeStartController) {
      setState(() {
        _timeStartController.text = picked.format(context);
      });
    }
  }

  Widget _zoneTexte(String label, TextEditingController controller,
      {IconData? icon, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: RichText(
              text: TextSpan(
                text: label.contains(' ')
                    ? label.substring(0, label.lastIndexOf(' '))
                    : label,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  if (label.contains(' '))
                    TextSpan(
                      text: " ${label.split(' ').last} * :",
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  if (!label.contains(' '))
                    const TextSpan(
                      text: " * :",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              readOnly: onTap !=
                  null, // Rendre le champ non éditable si onTap est défini
              onTap: onTap, // Exécuter la fonction onTap si elle est définie
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
                prefixIcon:
                    icon != null ? Icon(icon, color: Colors.grey[600]) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYesNoCheckbox(String label, bool valueYes, bool valueNo,
      ValueChanged<bool> onYesChanged, ValueChanged<bool> onNoChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligner les labels à gauche
        children: [
          // Label à gauche
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: label.contains(' ')
                  ? label.substring(0, label.lastIndexOf(' '))
                  : label,
              style: const TextStyle(color: Colors.black, fontFamily: 'Inter'),
              children: [
                TextSpan(
                  text: label.contains(' ')
                      ? " ${label.split(' ').last} * :"
                      : " * :",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 8.0), // Espacement entre le label et les checkboxes
          // Checkboxes centrées
          Center(
            child: Wrap(
              spacing: 20.0, // Espace entre les colonnes
              runSpacing: 10.0, // Espace si les éléments vont à la ligne
              alignment:
                  WrapAlignment.center, // Centre horizontalement les checkboxes
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: valueYes,
                      onChanged: (bool? value) {
                        onYesChanged(value ?? false);
                      },
                    ),
                    const Text(
                      "Oui",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.italic,
                        color: Color.fromRGBO(155, 3, 63, 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: valueNo,
                      onChanged: (bool? value) {
                        onNoChanged(value ?? false);
                      },
                    ),
                    const Text(
                      "Non",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.italic,
                        color: Color.fromRGBO(155, 3, 63, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildNBPersonnesInputRow(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: RichText(
              text: TextSpan(
                text: label.substring(0, label.lastIndexOf(' ')),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: " ${label.split(' ').last} * :",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoissonInputRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "$label * :",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une quantité';
                }
                if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Veuillez entrer une quantité valable';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(155, 3, 63, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organiser un événement',
            style: TextStyle(color: Colors.black, fontFamily: 'Inter')),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Ajout d'un padding autour du formulaire
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Détails
                _buildCenteredTitle("Détails"),
                _zoneTexte("Titre", _titreController),
                _zoneTexte("Jour", _dateController,
                    onTap: () => _selectDate(context),
                    icon: Icons.calendar_today),
                _zoneTexte("Heure", _timeStartController,
                    onTap: () => _selectTime(context), icon: Icons.access_time),
                _zoneTexte("Salle(s) à réserver", _salleController),
                _zoneTexte("Durée du nettoyage", _dureeNettoyageController),

                // Public visé et sécurité
                _buildCenteredTitle("Public visé et Sécurité"),
                _buildNBPersonnesInputRow(
                    "Affluence attendue", _affluenceAttendueController),
                _zoneTexte("Public visé", _publicViseController),

                // Checkbox group for "Personnes extérieures"
                _buildYesNoCheckbox(
                  "Personnes extérieures",
                  _personnesExterieuresOui,
                  _personnesExterieuresNon,
                  (bool value) {
                    setState(() {
                      _personnesExterieuresOui = value;
                      _personnesExterieuresNon = !value;
                    });
                  },
                  (bool value) {
                    setState(() {
                      _personnesExterieuresNon = value;
                      _personnesExterieuresOui = !value;
                    });
                  },
                ),

                // Checkbox group for "Présence Vigiles/SSIAP"
                _buildYesNoCheckbox(
                  "Présence Vigiles/SSIAP",
                  _presenceVigileOui,
                  _presenceVigileNon,
                  (bool value) {
                    setState(() {
                      _presenceVigileOui = value;
                      _presenceVigileNon = !value;
                    });
                  },
                  (bool value) {
                    setState(() {
                      _presenceVigileNon = value;
                      _presenceVigileOui = !value;
                    });
                  },
                ),
                _buildNBPersonnesInputRow(
                    "Nombre de personnes", _nombrePersonnesController),

                // Boisson
                _buildCenteredTitle("Boisson"),
                _zoneTexte("Type de boisson", _typeBoissonController),
                _buildBoissonInputRow(
                    "Quantité de boisson (L)", _quantiteBoissonController),
                _zoneTexte(
                    "Équipe de distribution", _equipeDistributionController),

                // Équipe organisatrice
                _buildCenteredTitle("Equipe Organisatrice"),
                _zoneTexte("Responsable de l'événement",
                    _responsableEvenementController),
                _buildNBPersonnesInputRow("Numéro de téléphone du responsable",
                    _telephoneResponsableController),
                _zoneTexte(
                    "Entité organisatrice", _entiteOrganisatriceController),
                _zoneTexte("Référent BDE", _referentBDEController),
                _buildNBPersonnesInputRow("Numéro de téléphone du référent",
                    _telephoneReferentController),
                // Lutte VSS
                _buildCenteredTitle("Lutte VSS"),
                _zoneTexte("Responsable de la lutte contre le VSS",
                    _responsableVSSController),
                _zoneTexte("Lieux Safe Place", _lieuxSafePlaceController),

                // Submit Button
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 103,
                      height: 31,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: const Color.fromARGB(255, 100, 3, 42),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifSoiree(
                                          titreController: _titreController,
                                          dateController: _dateController,
                                          timeStartController:
                                              _timeStartController,
                                          salleController: _salleController,
                                          dureeNettoyageController:
                                              _dureeNettoyageController,
                                          affluenceAttendueController:
                                              _affluenceAttendueController,
                                          publicViseController:
                                              _publicViseController,
                                          personnesExterieures:
                                              _personnesExterieuresOui, // Ou la variable correspondante
                                          presenceVigile:
                                              _presenceVigileOui, // Ou la variable correspondante
                                          nombrePersonnesController:
                                              _nombrePersonnesController,
                                          typeBoissonController:
                                              _typeBoissonController,
                                          quantiteBoissonController:
                                              _quantiteBoissonController,
                                          equipeDistributionController:
                                              _equipeDistributionController,
                                          responsableEvenementController:
                                              _responsableEvenementController,
                                          telephoneResponsableController:
                                              _telephoneResponsableController,
                                          entiteOrganisatriceController:
                                              _entiteOrganisatriceController,
                                          referentBDEController:
                                              _referentBDEController,
                                          telephoneReferentController:
                                              _telephoneReferentController,
                                          responsableVSSController:
                                              _responsableVSSController,
                                          lieuxSafePlaceController:
                                              _lieuxSafePlaceController,
                                        )),
                              );
                            }
                          },
                          child: const Text(
                            'Envoyer',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
