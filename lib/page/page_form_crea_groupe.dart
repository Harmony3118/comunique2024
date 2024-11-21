import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// il faut importer le package du widget bouton et enlever la class widgetbouton d'ici que j'ai copié collé

// Le code fonctionne mais voici quelque dernier points qui peuvent être amélioré :
//rajouter une image a la place du check
//faire une croix pour pouvoir désactiver
//enlever la bare en dessous des participants

//eventuelement mettre class AppData avec le nom des participants dans un autre fichier global
class AppData {
  static List<MultiSelectItem<String>> participants = [
    MultiSelectItem("Option1", "Participant 1"),
    MultiSelectItem("Option2", "Participant 2"),
    MultiSelectItem("Option3", "Participant 3"),
    MultiSelectItem("Option4", "Participant 4"),
    MultiSelectItem("Option5", "profeseur  4"),
    MultiSelectItem("Option6", "administrateur 4"),
    MultiSelectItem("Option7", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
    MultiSelectItem("Option8", "Participant 4"),
  ];
}

class CreaGroupe extends StatefulWidget {
  @override
  _CreaGroupeState createState() => _CreaGroupeState();
}

class _CreaGroupeState extends State<CreaGroupe> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController secondFieldController = TextEditingController();
  DateTime? selectedDate;
  List<String> selectedParticipants = [];

  void createGroup() {
    final groupName = groupNameController.text.trim();
    final secondField = secondFieldController.text.trim();

    if (groupName.isEmpty ||
        selectedParticipants.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    final groupData = {
      'groupName': groupName,
      'secondField': secondField,
      'date': selectedDate?.toIso8601String(),
      'participants': selectedParticipants,
    };

    print("Group Data: $groupData");
    // Send `groupData` to your external database
    // Example: sendToDatabase(groupData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                const Text(
                  "Nouveau groupe de diffusion",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(thickness: 1, color: Colors.black),
            const TitresTextes(text: "Nom du groupe *"),
            PetiteBoite(
              controller: groupNameController,
              hintText: "",
            ),
            const Diviseur(),
            const TitresTextes(text: "Participants *"),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Allows the column to grow dynamically
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MultiSelectDialogField(
                          items: AppData.participants,
                          title: const Text(""),
                          searchable: true,
                          buttonText: const Text(
                            "Sélectionnez les Participants",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          buttonIcon: const Icon(
                            Icons
                                .search, // Replacing the down arrow with a search icon
                            color: Color.fromARGB(255, 100, 3, 42),
                          ),
                          initialValue: selectedParticipants,
                          onConfirm: (values) {
                            setState(() {
                              selectedParticipants = values.cast<String>();
                              print(
                                  "Selected Participants: $selectedParticipants");
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children:
                              selectedParticipants.map((participantValue) {
                            // Find the corresponding label for the value, if necessary
                            final participantLabel = AppData.participants
                                .firstWhere(
                                    (item) => item.value == participantValue)
                                .label;

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Chip(
                                label: Text(
                                  participantValue, // Display the label, or use participantValue if preferred
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: const Color.fromARGB(
                                    255, 100, 3, 42), // Chip color
                                deleteIcon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onDeleted: () {
                                  setState(() {
                                    selectedParticipants.remove(
                                        participantValue); // Remove by value
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Diviseur(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.1,
                    1.5,
                    0.0,
                    1.5,
                  ),
                  child: const Text(
                    "Date de fin du groupe *",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CalendarIcon(
                      onDateSelected: (pickedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  0.0, 10.0, 0.0, 10), // Removed the extra const keyword
              child: TitresTextes(
                  text:
                      "Diffuson d'infos *"), // Removed the extra const keyword
            ),
            PetiteBoite(
              controller: secondFieldController,
              hintText: "",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100.0, 10, 0.0, 0),
              child: WidgetBouton(
                typeBouton: 3,
                texte: 'Créer',
                maFonction: createGroup,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarIcon extends StatefulWidget {
  final Function(DateTime?)
      onDateSelected; // Callback to retrieve selected date

  const CalendarIcon({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _CalendarIconState createState() => _CalendarIconState();
}

class _CalendarIconState extends State<CalendarIcon> {
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(picked); // Pass the selected date back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _pickDate(context),
          color: const Color.fromARGB(255, 100, 3, 42), // Customize color
        ),
        Text(
          _selectedDate != null
              ? "${_selectedDate!.toLocal()}".split(' ')[0]
              : "",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

//les titres des parties

class TitresTextes extends StatelessWidget {
  final String text; // Required text to display

  const TitresTextes({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

//les divider qui sont reutilisé

class Diviseur extends StatelessWidget {
  final double thickness;
  final Color color;
  final EdgeInsetsGeometry margin;

  const Diviseur({
    Key? key,
    this.thickness = 3.0,
    this.color = const Color.fromARGB(255, 100, 3, 42),
    this.margin = const EdgeInsets.symmetric(horizontal: 50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        height: thickness,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: margin,
      ),
    );
  }
}

// les textField petit qui sont utilisé deux fois

class PetiteBoite extends StatelessWidget {
  final double widthFactor;
  final double height;
  final EdgeInsetsGeometry padding;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const PetiteBoite({
    Key? key,
    this.widthFactor = 0.8,
    this.height = 40,
    this.padding = const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0),
    this.hintText = '',
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: TextField(
            maxLines: 1,
            scrollPhysics: const BouncingScrollPhysics(),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 100, 3, 42),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 100, 3, 42),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: const Color(0xFFD9D9D9),
              hintText: hintText,
            ),
            onChanged: onChanged, // Callback to capture text input
          ),
        ),
      ),
    );
  }
}

// j'ai copié collé le widget bouton il sera à enlever apres le merge

class WidgetBouton extends StatelessWidget {
  const WidgetBouton(
      {Key? key,
      required this.typeBouton,
      required this.texte,
      required this.maFonction})
      : super(key: key);
  final int typeBouton;
  final String texte;
  final void Function()? maFonction;
  static Color backgroundColor = const Color.fromRGBO(100, 3, 41, 1);
  static Color foregroundColor = Colors.white;

  void getCouleur() {
    if (typeBouton == 2) {
      backgroundColor = const Color.fromRGBO(215, 215, 215, 1);
      foregroundColor = Colors.black;
    } else if (typeBouton == 3) {
      backgroundColor = const Color.fromRGBO(100, 3, 41, 0.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCouleur();
    return ElevatedButton(
      onPressed: maFonction,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(texte),
    );
  }
}

class MultiSelectSearchPage extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const MultiSelectSearchPage({required this.onSelectionChanged, Key? key})
      : super(key: key);

  @override
  _MultiSelectSearchPageState createState() => _MultiSelectSearchPageState();
}

class _MultiSelectSearchPageState extends State<MultiSelectSearchPage> {
  List<String> _selectedItems = []; // Tracks the selected 'value' items.

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiSelectDialogField(
          items: AppData.participants,
          title: const Text("Select Options"),
          searchable: true,
          buttonIcon: const Icon(
            Icons.search, // Search icon
            color: Colors.black,
          ),
          buttonText: const Text("Select Items"),
          initialValue: _selectedItems,
          onConfirm: (values) {
            setState(() {
              _selectedItems = values.cast<String>(); // Store only the 'value'
            });

            // Notify the parent widget of changes if needed
            widget.onSelectionChanged(_selectedItems);
          },
        ),
        const SizedBox(height: 10),
        Wrap(
          children: _selectedItems.map((value) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Chip(
                label: Text(
                  value, // Display the 'value' directly
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 100, 3, 42),
                deleteIcon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onDeleted: () {
                  setState(() {
                    _selectedItems.remove(value); // Remove by 'value'
                  });

                  widget.onSelectionChanged(_selectedItems); // Notify parent
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
