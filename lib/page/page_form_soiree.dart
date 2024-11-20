import 'package:flutter/material.dart';

class FormSoiree extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<FormSoiree> {
  final _formKey = GlobalKey<FormState>();

  // Détails (partie)
  String _titre = '';
  DateTime? _startDate;
  TimeOfDay? _startTime;
  String _salle = '';
  String _dureeNettoyage = '';

  // Public visé et sécurité (partie)
  int _affluenceAttendue = 0;
  String _publicVise = '';
  bool _personnesExterieuresOui = false;
  bool _personnesExterieuresNon = true;
  bool _presenceVigileOui = false;
  bool _presenceVigileNon = true;
  int _nombrePersonnes = 0;

  // Boisson (partie)
  String _typeBoisson = '';
  double _quantiteBoisson = 0.0;
  String _equipeDistribution = '';

  // Équipe organisatrice (partie)
  String _responsableEvenement = '';
  String _telephoneResponsable = '';
  String _entiteOrganisatrice = '';
  String _referentBDE = '';
  String _telephoneReferent = '';

  // Lutte VSS (partie)
  String _responsableVSS = '';
  String _lieuxSafePlace = '';

  // Controllers for date and time fields
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  Widget _zoneTexte(String label, {String? initialValue, TextInputType? keyboardType, bool readOnly = false, VoidCallback? onTap, Icon? icon, ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 150.0,
              child: Text(
                "$label :",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 3, 42),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        icon,
                        const SizedBox(width: 10.0),
                      ],
                      Expanded(
                        child: TextFormField(
                          initialValue: initialValue,
                          readOnly: readOnly,
                          keyboardType: keyboardType,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onTap: onTap,
                          onChanged: onChanged,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildYesNoCheckbox(String label, bool valueYes, bool valueNo, ValueChanged<bool> onYesChanged, ValueChanged<bool> onNoChanged) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            "$label :",
            style: const TextStyle(color: Colors.black),
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
            const Text("Oui"),
            Checkbox(
              value: valueNo,
              onChanged: (bool? value) {
                onNoChanged(value ?? false);
              },
            ),
            const Text("Non"),
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
              const Text("Détails", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800,color: Color.fromARGB(255, 100, 3, 42))),
              const Divider(thickness: 1,color: Color.fromARGB(255, 100, 3, 42)),
              _zoneTexte("Titre", initialValue: _titre, onChanged: (value) => _titre = value),
              _zoneTexte("Jour", readOnly: true, onTap: () => _selectDate(context), icon: const Icon(Icons.calendar_today), initialValue: _dateController.text),
              _zoneTexte("Heure", readOnly: true, onTap: () => _selectTime(context), icon: const Icon(Icons.access_time), initialValue: _timeController.text),
              _zoneTexte("Salle(s) à réserver", initialValue: _salle, onChanged: (value) => _salle = value),
              _zoneTexte("Durée du nettoyage", initialValue: _dureeNettoyage, onChanged: (value) => _dureeNettoyage = value),

              // Public visé et sécurité
              const Text("Public visé et sécurité", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42))),
              const Divider(thickness: 1,color: Color.fromARGB(255, 100, 3, 42)),
              _zoneTexte("Affluence attendue", keyboardType: TextInputType.number, initialValue: _affluenceAttendue.toString(), onChanged: (value) => _affluenceAttendue = int.tryParse(value) ?? 0),
              _zoneTexte("Public visé", initialValue: _publicVise, onChanged: (value) => _publicVise = value),
              
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
              _zoneTexte("Nombre de personnes", keyboardType: TextInputType.number, initialValue: _nombrePersonnes.toString(), onChanged: (value) => _nombrePersonnes = int.tryParse(value) ?? 0),

              // Boisson
              const Text("Boisson", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800,color: Color.fromARGB(255, 100, 3, 42))),
              const Divider(thickness: 1,color: Color.fromARGB(255, 100, 3, 42)),
              _zoneTexte("Type de boisson", initialValue: _typeBoisson, onChanged: (value) => _typeBoisson = value),
              _zoneTexte("Quantité", keyboardType: const TextInputType.numberWithOptions(decimal: true), initialValue: _quantiteBoisson.toString(), onChanged: (value) => _quantiteBoisson = double.tryParse(value) ?? 0.0),
              _zoneTexte("Équipe de distribution", initialValue: _equipeDistribution, onChanged: (value) => _equipeDistribution = value),

              // Équipe organisatrice
              const Text("Équipe organisatrice", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800,color: Color.fromARGB(255, 100, 3, 42))),
              const Divider(thickness: 1,color: Color.fromARGB(255, 100, 3, 42)),
              _zoneTexte("Responsable de l’événement", initialValue: _responsableEvenement, onChanged: (value) => _responsableEvenement = value),
              _zoneTexte("Téléphone du responsable", keyboardType: TextInputType.phone, initialValue: _telephoneResponsable, onChanged: (value) => _telephoneResponsable = value),
              _zoneTexte("Entité organisatrice", initialValue: _entiteOrganisatrice, onChanged: (value) => _entiteOrganisatrice = value),
              _zoneTexte("Référent BDE", initialValue: _referentBDE, onChanged: (value) => _referentBDE = value),
              _zoneTexte("Téléphone du référent", keyboardType: TextInputType.phone, initialValue: _telephoneReferent, onChanged: (value) => _telephoneReferent = value),

              // Lutte VSS
              const Text("Lutte VSS", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Color.fromARGB(255, 100, 3, 42))),
              const Divider(thickness: 1,color: Color.fromARGB(255, 100, 3, 42)),
              _zoneTexte("Responsable VSS", initialValue: _responsableVSS, onChanged: (value) => _responsableVSS = value),
              _zoneTexte("Lieux de la Safe Place", initialValue: _lieuxSafePlace, onChanged: (value) => _lieuxSafePlace = value),

              const SizedBox(height: 20.0),
              Container(
                width: 300.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 103,
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: const Color.fromARGB(255, 100, 3, 42),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Envoyer le formulaire
                        }
                      },
                      child: const Text('Envoyer', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}