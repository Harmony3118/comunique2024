import 'package:flutter/material.dart';
// il faut importer le package du widget bouton 
class CreaGroupe extends StatelessWidget {  // j'ai changé a statefull pour pouvoir utiliser la class _LesInfosDesText
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

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
                  //FontWeight(400),
                ),
              ],
            ),

            // faire un truc pour que quand on appui dessus ca nous envoie en arrière

            const Divider(
              thickness: 1,
              color: Colors.black,
            ),

            const TitresTextes(text: "Nom du groupe *"),

            PetiteBoite(
              hintText: "", // on veut pas d'inscription en particulier 
              onChanged: (text) {
                // fonction pour ramasser les inscription 
              },
            ),

            const Diviseur(),

            const TitresTextes(text: "Participants *"),
            
            // Champ de recherche avec TextField
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0.0),

                child: FractionallySizedBox(
                  widthFactor: 0.98,
                  child: FloatingSearchBar(
                    onItemSelected: (selectedText) {
                      print("Selected item: $selectedText");
                      // Perform actions with selectedText if needed
                      },
                    
                  ), 
                ),
              
            ),
// on enleve ce qui est en dessous car c'est mtn dans la class AutocompletExample car sinon les widgets en dessous cachent la liste des options
            // Divider pour séparer les sections
            const Diviseur(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB( MediaQuery.of(context).size.width * 0.1, 1.5,0.0, 1.5), //bidouille car le calendrier juste après faisait que je ne pouvais pas utiliser la class TitresText
                  child: const Text("Date de fin du groupe *",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  ),
                ),
                // calendrier 
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CalendarIcon(
                      onDateSelected: (selectedDate) {
                        // Use the selected date here
                      },
                    ),
                  ),
                ),
              ],
            ),


            // Ajouter un bouton ou un widget pour sélectionner une date
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10), // Removed the extra const keyword
              child: TitresTextes(text: "Nom du groupe *"), // Removed the extra const keyword
            ),
            PetiteBoite(
              hintText: "", // on veut pas d'inscription en particulier 
              onChanged: (text) {
                // fonction pour ramasser les inscription 
              },
            ),
            // rajouter un petit snackbar apres le bouton créer 
            Padding(
              padding: const EdgeInsets.fromLTRB(100.0, 10, 0.0, 0),
              child: WidgetBouton(
                typeBouton: 3, // Set the button type
                texte: 'Créer', // Text to display on the button
                maFonction: () {
                  // Define the action on button press
                  // faire la fonction qui renvoie à une page confirmant la creation du groupe
                },
              ),
            ),
            
          ],
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




class FloatingSearchBar extends StatefulWidget {
  final Function(String)? onItemSelected;

  const FloatingSearchBar({Key? key, this.onItemSelected}) : super(key: key);

  @override
  _FloatingSearchBarState createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  List<String> _filteredOptions = [];
  final List<String> _allOptions = [
    'Bob Rose',
    'Alice Pasrugeux',
    'Justin Time',
    'Justin Case',
    'Jamel Case',
    'Pascal Case',
    'Tom De Lasuite',
    'Charlie Quide',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _removeOverlay();
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height + 5,
        width: renderBox.size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            height: 200,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView.builder(
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredOptions[index]),
                  onTap: () {
                    _controller.text = _filteredOptions[index];
                    widget.onItemSelected?.call(_filteredOptions[index]);
                    _removeOverlay();
                    setState(() {
                      _filteredOptions.clear();
                    });
                    _focusNode.unfocus();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onTextChanged(String text) {
    setState(() {
      _filteredOptions = _allOptions
          .where((option) => option.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });

    if (_filteredOptions.isNotEmpty && text.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: _onTextChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 100, 3, 42),
          ),
          filled: true,
          fillColor: const Color(0xFFD9D9D9),
        ),
      ),
    );
  }
}
