import 'package:flutter/material.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:comunique2024/page/page_navigation.dart';

class Absence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: MyForm(),
    ));
  }
}

class VerifAbsence extends StatelessWidget {
  final List<String> professeur;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String motif;
  final String nomFichier;

  VerifAbsence(
      {required this.professeur,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.motif,
      required this.nomFichier}); 

  @override
  Widget build(BuildContext context) {
    String stringStartTime = startTime!.minute < 10
        ? '${startTime!.hour}h0${startTime!.minute}'
        : '${startTime!.hour}h${startTime!.minute}';
    String stringEndTime = endTime!.minute < 10
        ? '${endTime!.hour}h0${endTime!.minute}'
        : '${startTime!.hour}h${startTime!.minute}';
    String stringStartDate =
        '${startDate!.day}/${startDate!.month}/${startDate!.year}';
    String stringEndDate = '${endDate!.day}/${endDate!.month}/${endDate!.year}';
    String stringProfesseur = professeur.join(", ");

    return Scaffold(
        body: Center(
            child: DefaultTextStyle(
                style: TextStyle(fontFamily: 'Inter', color: Colors.black),
                child: Column(children: [
                  Row(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasePage(
                                    currentIndex: 4, body: ContactPage())),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    Expanded(
                        child: Text(
                      'Justifier mon absence',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
                  ]),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 319.0,
                                  height: 338.0,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 100, 3, 42),
                                        width: 2.0,
                                      )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Vérification",
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
                                                  "J'ai été absent du $stringStartDate à partir de $stringStartTime jusqu'au $stringEndDate à $stringEndTime pour cause de $motif.\n\n Le(s) professeur(s) concernés sont : $stringProfesseur.\n\n Pièces(s) justificative(s) :\n\n • ",
                                            ),
                                            TextSpan(
                                                text: "$nomFichier",
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic))
                                          ])),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  width: 300.0,
                                  child: Row(children: [
                                    Container(
                                        width: 103,
                                        height: 31,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          color: Color.fromARGB(
                                              255, 215, 215, 215),
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, {
                                                professeur: professeur,
                                                startDate: startDate,
                                                endDate: endDate,
                                                startTime: startTime,
                                                endTime: endTime,
                                                motif: motif,
                                                nomFichier: nomFichier,
                                              });
                                            },
                                            child: const Text('Modifier',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                )))),
                                    Expanded(
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
                                            )))
                                  ]),
                                )
                              ])))
                ]))));
  }
}

class ConfirmationAbsence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: DefaultTextStyle(
                style: TextStyle(fontFamily: 'Inter', color: Colors.black),
                child: Column(children: [
                  Row(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BasePage(
                                    currentIndex: 4, body: ContactPage())),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    Expanded(
                        child: Text(
                      'Justifier mon absence',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
                  ]),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 319.0,
                                  height: 338.0,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 100, 3, 42),
                                        width: 2.0,
                                      )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Color.fromARGB(
                                                255, 15, 169, 88),
                                            size: 28,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "Réussi",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20.0),
                                      const Text(
                                        "Votre demande de justification a bien été transmise à l'administration, à votre responsable de promotion et au(x) professeur(s) concerné(s).",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Container(
                                        width: 300.0,
                                        child: Expanded(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: 176,
                                                  height: 31,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19),
                                                    color: const Color.fromARGB(
                                                        255, 100, 3, 42),
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
                                                                            const ContactPage())));
                                                      },
                                                      child: const Text(
                                                          "Retourner à l'accueil",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                ))),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                              ])))
                ]))));
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _professeur = [];
  List<String> professeurs = [
    "Professeur1@ensc.fr",
    "Professeur2@ensc.fr",
    "Professeur3@ensc.fr"
  ];
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _motif = '';
  String _nomFichier = 'Sélectionner un fichier';
  bool showMultiselect = true;
  int nbProf = 0;

  @override
  void initState() {
    super.initState();
    _startDateController.text = 'jj/mm/aaaa';
    _endDateController.text = 'jj/mm/aaaa';
    _startTimeController.text = '00h00';
    _endTimeController.text = '00h00';
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text =
              '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}';
        } else {
          _endDate = picked;
          _endDateController.text =
              '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}';
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          if (_startTime!.minute < 10) {
            _startTimeController.text =
                '${_startTime!.hour}h0${_startTime!.minute}';
          } else {
            _startTimeController.text =
                '${_startTime!.hour}h${_startTime!.minute}';
          }
        } else {
          _endTime = picked;
          if (_endTime!.minute < 10) {
            _endTimeController.text = '${_endTime!.hour}h0${_endTime!.minute}';
          } else {
            _endTimeController.text = '${_endTime!.hour}h${_endTime!.minute}';
          }
        }
      });
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty || value == 'jj/mm/aaaa') {
      return 'Veuillez sélectionner une date.';
    }
    return null;
  }

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty || value == '00h00') {
      return 'Veuillez sélectionner une heure.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Inter', color: Colors.black),
          child: Column(children: [
            Row(children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasePage(
                              currentIndex: 4, body: const ContactPage())),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              const Expanded(
                  child: Text(
                'Justifier mon absence',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))
            ]),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(children: [
                      const Text('Professeur'),
                      const SizedBox(width: 5.0),
                      const Text('*',
                          style: TextStyle(
                              color: Color.fromARGB(255, 100, 3, 42))),
                      const SizedBox(width: 12.0),
                      Container(
                          child: showMultiselect
                              ? Container(
                                  height: 41,
                                  width: 206,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 217, 217, 217),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 100, 3,
                                          42), // Couleur de la bordure
                                      width: 1.5, // Largeur de la bordure
                                    ),
                                  ),
                                  child: MultiSelectDialogField(
                                    items: professeurs
                                        .map((e) =>
                                            MultiSelectItem<String>(e, e))
                                        .toList(),
                                    listType: MultiSelectListType.CHIP,
                                    buttonText: const Text(
                                      "Professeur(s) concerné(s)",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    buttonIcon: const Icon(
                                      Icons.expand_more,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      size: 13,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez sélectionner le(s) professeur(s) concerné(s).';
                                      }
                                      return null;
                                    },
                                    onConfirm: (values) {
                                      setState(() {
                                        _professeur =
                                            values.cast<String>().toList();
                                        showMultiselect = false;
                                        nbProf = _professeur.length - 1;
                                      });
                                    },
                                  ),
                                )
                              : Container(
                                  height: 41,
                                  width: 206,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 217, 217, 217),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 100, 3,
                                          42), // Couleur de la bordure
                                      width: 1.5, // Largeur de la bordure
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _professeur[0] +
                                            (nbProf > 0 ? ' + $nbProf ' : ''),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _professeur = [];
                                              showMultiselect = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ))
                                    ],
                                  )))
                    ]),
                    Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 100, 3, 42),
                    ),
                    Row(
                      children: [
                        Text('Date'),
                        SizedBox(width: 5.0),
                        Text('*',
                            style: TextStyle(
                                color: Color.fromARGB(255, 100, 3, 42))),
                        SizedBox(width: 5.0),
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5.0),
                        Text('Du'),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _startDateController,
                            validator: _validateDate,
                            onTap: () => _selectDate(context, true),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text('Au'),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _endDateController,
                            validator: _validateDate,
                            onTap: () => _selectDate(context, false),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Heure'),
                        SizedBox(width: 5.0),
                        Text('*',
                            style: TextStyle(
                                color: Color.fromARGB(255, 100, 3, 42))),
                        SizedBox(width: 5.0),
                        Icon(Icons.access_time),
                        SizedBox(width: 5.0),
                        Text('De'),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 60.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _startTimeController,
                            validator: _validateTime,
                            onTap: () => _selectTime(context, true),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text('A'),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 60.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _endTimeController,
                            validator: _validateTime,
                            onTap: () => _selectTime(context, false),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 100, 3, 42),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text("Motif"),
                          SizedBox(width: 5.0),
                          Text('*',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 100, 3, 42))),
                        ]),
                        SizedBox(height: 16.0),
                        Container(
                            height: 118,
                            width: 342,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 217, 217, 217),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Color.fromARGB(
                                    255, 100, 3, 42), // Couleur de la bordure
                                width: 1.5, // Largeur de la bordure
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer le motif de votre abscence.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _motif = value!;
                              },
                            )),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 100, 3, 42),
                    ),
                    Row(children: [
                      Text("Fichier"),
                      SizedBox(width: 5.0),
                      Text('*',
                          style: TextStyle(
                              color: Color.fromARGB(255, 100, 3, 42))),
                      SizedBox(width: 16.0),
                      Icon(Icons.attach_file),
                      SizedBox(width: 16.0),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 100, 3, 42), // Couleur de la bordure
                            width: 1.5, // Largeur de la bordure
                          ),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 217, 217, 217),
                            ),
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                String fileName = result.files.single.name;
                                setState(() {
                                  _nomFichier = fileName;
                                });
                              } else {
                                setState(() {
                                  _nomFichier = 'Sélectionner un fichier';
                                });
                              }
                            },
                            child: Text(
                              _nomFichier,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            )),
                      )
                    ]),
                    Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 100, 3, 42),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Map result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BasePage(
                                        currentIndex: 4,
                                        body: VerifAbsence(
                                            professeur: _professeur,
                                            startDate: _startDate,
                                            endDate: _endDate,
                                            startTime: _startTime,
                                            endTime: _endTime,
                                            motif: _motif,
                                            nomFichier: _nomFichier)),
                                  ));

                              _professeur = result['professeur'];
                              _startDateController.text = result['startDate'];
                              _endDateController.text = result['endDate'];
                              _startTimeController.text = result['startTime'];
                              _endTimeController.text = result['endTime'];
                              _motif = result['motif'];
                              _nomFichier = result['nomFichier'];
                            }
                          },
                          child: Text(
                            'Envoyer',
                            style: TextStyle(
                                color: Color.fromARGB(255, 100, 3, 42),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose;
  }
}
