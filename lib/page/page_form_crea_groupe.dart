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
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0),
              child: SizedBox(
                height: 40,
                child: FractionallySizedBox(
                  widthFactor: 0.98,
                  child: TextField(
                    maxLines: 1,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12), // Adjusted padding for control
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
                      labelText: "",
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              ),
            ),

            // Divider pour séparer les sections
            const Diviseur(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0), // Removed the extra const keyword
                  child: TitresTextes(text: "Date de fin du groupe *"), // Removed the extra const keyword
                ),

                // calendrier 
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CalendarIcon(
                        onDateSelected: (selectedDate) {
                          // Use the selected date here 
                        },
                      ),
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
            // bouton créer
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

/*      À revoir pour recuperer le text

class InfoTexte extends StatefulWidget {
  @override
  _InfoTexte createState() => _<InfoTexte();
}

class _InfoTexte  extends State<InfoTexte> {
  final TextEditingController _nomDuGroupeController = TextEditingController();
  final TextEditingController _diffusionDinfoController = TextEditingController();

  void _retrieveText() {
    String entreNomDuGroupe = _nomDuGroupeController.text;
    String entreDiffusionDinfo = _diffusionDinfoController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTexte(
          hintText: "Enter text here",
          controller: _nomDuGroupeController,
        ),
        ElevatedButton(
          onPressed: _retrieveText,
          child: Text("Retrieve Text"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nomDuGroupeController.dispose();
    super.dispose();
  }
}

*/



