import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormSoiree extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<FormSoiree> {
  final _formKey = GlobalKey<FormState>();

  // Détails (partie)
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _salleController = TextEditingController();
  final TextEditingController _dureeNettoyageController = TextEditingController();

  // Public visé et sécurité (partie)
  final TextEditingController _affluenceAttendueController = TextEditingController();
  final TextEditingController _publicViseController = TextEditingController();
  bool _personnesExterieuresOui = false;
  bool _personnesExterieuresNon = true;
  bool _presenceVigileOui = false;
  bool _presenceVigileNon = true;
  final TextEditingController _nombrePersonnesController= TextEditingController();


  // Boisson (partie)
  final TextEditingController _typeBoissonController = TextEditingController();
  final TextEditingController _quantiteBoissonController = TextEditingController();
  final TextEditingController _equipeDistributionController = TextEditingController();

  // Équipe organisatrice (partie)
  final TextEditingController _responsableEvenementController = TextEditingController();
  final TextEditingController _telephoneResponsableController = TextEditingController();
  final TextEditingController _entiteOrganisatriceController = TextEditingController();
  final TextEditingController _referentBDEController = TextEditingController();
  final TextEditingController _telephoneReferentController = TextEditingController();

  // Lutte VSS (partie)
  final TextEditingController _responsableVSSController = TextEditingController();
  final TextEditingController _lieuxSafePlaceController = TextEditingController();
  

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

  
  Widget _zoneTexte(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: Text(
              "$label *",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Autorise uniquement les entiers
              ],
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

  Widget _buildYesNoCheckbox(String label, bool valueYes, bool valueNo, ValueChanged<bool> onYesChanged, ValueChanged<bool> onNoChanged) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            "$label :",
            style: const TextStyle(color: Colors.black, fontFamily: 'Inter'),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: valueYes,
              onChanged: (bool? value) {
                onYesChanged(value ?? false);
              },
            ),
            const Text("Oui", style: TextStyle(fontFamily: 'Inter')),
            Checkbox(
              value: valueNo,
              onChanged: (bool? value) {
                onNoChanged(value ?? false);
              },
            ),
            const Text("Non", style: TextStyle(fontFamily: 'Inter')),
          ],
        ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organiser un événement', style: TextStyle(color: Colors.black, fontFamily: 'Inter')),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),  // Ajout d'un padding autour du formulaire
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Détails
                const Text("Détails", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42), fontFamily: 'Inter')),
                const Divider(thickness: 1, color: Color.fromARGB(255, 100, 3, 42)),
                _zoneTexte("Titre", _titreController),
                _zoneTexte("Jour", _dateController),
                _zoneTexte("Heure",  _timeStartController),
                _zoneTexte("Salle(s) à réserver", _salleController),
                _zoneTexte("Durée du nettoyage",_dureeNettoyageController ),

                // Public visé et sécurité
                const Text("Public visé et sécurité", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42), fontFamily: 'Inter')),
                const Divider(thickness: 1, color: Color.fromARGB(255, 100, 3, 42)),
                _zoneTexte("Affluence attendue", _affluenceAttendueController  ),
                _zoneTexte("Public visé",_publicViseController  ),

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
                _zoneTexte("Nombre de personnes",_nombrePersonnesController),

                // Boisson
                const Text("Boisson", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42), fontFamily: 'Inter')),
                const Divider(thickness: 1, color: Color.fromARGB(255, 100, 3, 42)),
                _zoneTexte("Type de boisson", _typeBoissonController),
                _zoneTexte("Quantité de boisson (L)", _quantiteBoissonController),
                _zoneTexte("Équipe de distribution",  _equipeDistributionController),

                // Équipe organisatrice
                const Text("Équipe organisatrice", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42), fontFamily: 'Inter')),
                const Divider(thickness: 1, color: Color.fromARGB(255, 100, 3, 42)),
                _zoneTexte("Responsable de l'événement",_responsableEvenementController),
                _zoneTexte("Numéro de téléphone du responsable",_telephoneResponsableController),
                _zoneTexte("Entité organisatrice",_entiteOrganisatriceController),
                _zoneTexte("Référent BDE", _referentBDEController),
                _zoneTexte("Numéro de téléphone du référent",_telephoneReferentController),
                // Lutte VSS
                const Text("Lutte contre le VSS", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42), fontFamily: 'Inter')),
                const Divider(thickness: 1, color: Color.fromARGB(255, 100, 3, 42)),
                _zoneTexte("Responsable de la lutte contre le VSS",_responsableVSSController),
                _zoneTexte("Lieux Safe Place", _lieuxSafePlaceController),

                // Submit Button
               /* Expanded(
                                     child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: 103,
                                              height: 31,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(19),
                                                color: const Color.fromARGB(255, 100, 3, 42),
                                              ),
                                           child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                         builder: (context) =>
                                                                BasePage(
                                                                    currentIndex:
                                                                        4,
                                                                    body:
                                                                        ConfirmationAbsence())));
                                                  },
                                                  child: Text('Envoyer',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15))),
                                            ))),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
