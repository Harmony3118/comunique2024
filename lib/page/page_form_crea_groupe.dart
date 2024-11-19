

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart'; //a enlever eventuellement aussi sur le pubspec
// il faut importer le package du widget bouton 

final List<MultiSelectItem<String>> items = [
  MultiSelectItem("Option1", "Option 1"),
  MultiSelectItem("Option2", "Option 2"),
  MultiSelectItem("Option3", "Option 3"),
  MultiSelectItem("Option4", "Option 4"),
];

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

    if (groupName.isEmpty || selectedParticipants.isEmpty || selectedDate == null) {
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
      body: Center(
        child: SingleChildScrollView(
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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 400, // Set a reasonable max height
                ),
                child: MultiSelectDialogField(
                  items: [
                    MultiSelectItem("Option1", "Option 1"),
                    MultiSelectItem("Option2", "Essai 2"),
                    MultiSelectItem("Option3", "Option 3"),
                    MultiSelectItem("Option4", "Option 4"),
                  ],
                  title: Text(""),
                  initialValue: selectedParticipants,
                  searchable: true,
                  buttonText: const Text(
                    "Sélectionnez les Participants",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onConfirm: (values) {
                    setState(() {
                      selectedParticipants = values.cast<String>();
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    items: selectedParticipants.map((e) => MultiSelectItem(e, e)).toList(),
                    onTap: (item) {
                      setState(() {
                        selectedParticipants.remove(item); // Deselect on tap
                      });
                    },
                  ),
                ),
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
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10), // Removed the extra const keyword
              child: TitresTextes(text: "Diffuson d'infos *"), // Removed the extra const keyword
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
      ),
    );
  }
}


class CalendarIcon extends StatefulWidget {
  final Function(DateTime?) onDateSelected; // Callback to retrieve selected date

  const CalendarIcon({Key? key, required this.onDateSelected}) : super(key: key);

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
          _selectedDate != null ? "${_selectedDate!.toLocal()}".split(' ')[0] : "",
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
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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


class MultiSelectSearchBar extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  MultiSelectSearchBar({required this.onSelectionChanged});

  @override
  _MultiSelectSearchBarState createState() => _MultiSelectSearchBarState();
}

class _MultiSelectSearchBarState extends State<MultiSelectSearchBar> {
  final List<String> allOptions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Honeydew',
  ];

  final List<String> selectedOptions = [];
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  List<String> filteredOptions = [];
  OverlayEntry? dropdownOverlay;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      filterOptions(searchController.text);
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        showDropdown();
      } else {
        hideDropdown();
      }
    });
  }

  void filterOptions(String input) {
    setState(() {
      filteredOptions = allOptions
          .where((option) =>
              option.toLowerCase().contains(input.toLowerCase()) &&
              !selectedOptions.contains(option))
          .toList();
    });
    if (filteredOptions.isNotEmpty) {
      showDropdown();
    } else {
      hideDropdown();
    }
  }

  void addSelectedOption(String option) {
    setState(() {
      selectedOptions.add(option);
      searchController.clear();
      filterOptions(''); // Refilter to update options
    });
    widget.onSelectionChanged(selectedOptions);
  }

  void removeSelectedOption(String option) {
    setState(() {
      selectedOptions.remove(option);
    });
    widget.onSelectionChanged(selectedOptions);
  }

  void showDropdown() {
    if (dropdownOverlay != null) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height,
        width: renderBox.size.width,
        child: Material(
          elevation: 4,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredOptions.length,
              itemBuilder: (context, index) {
                final option = filteredOptions[index];
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    addSelectedOption(option);
                    hideDropdown();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    overlay?.insert(dropdownOverlay!);
  }

  void hideDropdown() {
    dropdownOverlay?.remove();
    dropdownOverlay = null;
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: selectedOptions.map((option) {
              return Chip(
                label: Text(option),
                deleteIcon: Icon(Icons.close),
                onDeleted: () => removeSelectedOption(option),
              );
            }).toList(),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: searchController,
            focusNode: searchFocusNode,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}



/*
class CustomMultipleSearch extends StatelessWidget {
  final List<String> options = [
    'Bob Rose',
    'Alice Pasrugeux',
    'Justin Time',
    'Justin Case',
    'Jamel Case',
    'Pascal Case',
    'Tom De Lasuite',
    'Charlie Quide',
  ];

  final Function(List<String>)? onSelectionChanged;

  CustomMultipleSearch({this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return MultipleSearchSelection<String>(
      items: options,
      fieldToCheck: (item) => item,
      searchField: TextField(
        decoration: InputDecoration(
          hintText: 'Participants...',
          prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 100, 3, 42)),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 100, 3, 42), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 100, 3, 42), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Color(0xFFD9D9D9),
        ),
      ),
      pickedItemBuilder: (item) => Chip(
        label: Text(item),
        backgroundColor: Colors.grey[200],
        deleteIcon: Icon(Icons.close, size: 18),
        onDeleted: () {
          // Handle the removal of the chip
        },
      ),
      itemBuilder: (context, item, isSelected) {
        assert(item is String, 'Item must be a String');
        return ListTile(
          title: Text(
            item as String,
            overflow: TextOverflow.ellipsis, // Prevent long text overflow
          ),
          trailing: isSelected
              ? Icon(Icons.check, color: Color.fromARGB(255, 100, 3, 42))
              : null,
        );
      },
      onPickedChange: (selectedItems) {
        onSelectionChanged?.call(selectedItems);
      },
      itemsVisibility: ShowedItemsVisibility.alwaysOn,
      fuzzySearch: FuzzySearch.jaro,
      showSelectAllButton: true,
    );
  }
}
*/


class MultiSelectSearchPage extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;

  const MultiSelectSearchPage({required this.onSelectionChanged, Key? key})
      : super(key: key);

  @override
  _MultiSelectSearchPageState createState() => _MultiSelectSearchPageState();
}

class _MultiSelectSearchPageState extends State<MultiSelectSearchPage> {
  final List<MultiSelectItem<String>> _items = [
    MultiSelectItem("Option1", "Option 1"),
    MultiSelectItem("Option2", "Option 2"),
    MultiSelectItem("Option3", "Option 3"),
    MultiSelectItem("Option4", "Option 4"),
  ];

  List<String> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: _items,
      title: Text("Select Options"),
      searchable: true,
      buttonText: Text("Select Items"),
      initialValue: _selectedItems, // Retains previously selected items
      onConfirm: (values) {
        setState(() {
          _selectedItems = values.cast<String>();
        });

        // Notify the parent widget of changes
        widget.onSelectionChanged(_selectedItems);
      },
      chipDisplay: MultiSelectChipDisplay(
        onTap: (item) {
          setState(() {
            _selectedItems.remove(item); // Deselect item on tap
          });

          // Notify the parent widget of changes
          widget.onSelectionChanged(_selectedItems);
        },
      ),
    );
  }
}