import 'package:flutter/material.dart';

class CreaGroupe extends StatelessWidget {  //j'ai changé a statefull pour pouvoir utiliser la class _LesInfosDesText
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children:[
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                 ),
            
                const Text(
                  "Nouveau groupe de diffusion",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  //FontWeight(400),
                ),
              ],
            ),
         
            // faire un truc pour que quand on appui dessus ca nous envoie en arrière

            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const Text("Nom du groupe *",
            style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
            ), // Astérisque

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 40,
                child: FractionallySizedBox(
                  widthFactor: 0.8,

                  child: TextField(
                    maxLines: 1,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(fontSize: 16), // Ensures consistent font size
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next, // Controls how the keyboard interacts
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
                    ),
                  )

                ),
              ),
             
              
            ),

            // Divider pour séparer les sections
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Vertical padding of 20
              child: Container(
                height: 3, // Thickness of the divider
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 100, 3, 42), // Divider color
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                margin: const EdgeInsets.symmetric(horizontal: 50), // Indent from the sides
              ),
            ),
            const Text("Participants *",
              style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
            ), // Asterisk

            // Champ de recherche avec TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Vertical padding of 20
              child: Container(
                height: 3, // Thickness of the divider
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 100, 3, 42), // Divider color
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                margin: const EdgeInsets.symmetric(horizontal: 50), // Indent from the sides
              ),
            ),

            const Text("Date de fin du groupe *",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            ),

            // Ajouter un bouton ou un widget pour sélectionner une date
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                onPressed: () { DateSelector();},  // faire fonctionner la fonction 

                icon: const Icon(Icons.calendar_today),  
                label: const Text("Sélectionner une date",  
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.white,
                  foregroundColor: const Color.fromARGB(255, 100, 3, 42),
                  side: const BorderSide(color: Color.fromARGB(255, 100, 3, 42)),
                ),


              ),
            ), 
          const Text("Diffusion d'infos *",
            style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
            ), // Astérisque

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 40,
                child: FractionallySizedBox(
                  widthFactor: 0.8,

                  child: TextField(
                    maxLines: 1,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(fontSize: 16), // Ensures consistent font size
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next, // Controls how the keyboard interacts
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
                    ),
                  )

                ),
              ),
             
              
            ),
          // bouton créer
          ],
        ),
      ),
    );
  }
}


class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate; // Update the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        onPressed: () => _selectDate(context), // Trigger date picker
        icon: const Icon(Icons.calendar_today),
        label: Text(
          selectedDate == null
              ? "Select Date"
              : "${selectedDate!.toLocal()}".split(' ')[0], // Format as YYYY-MM-DD
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromARGB(255, 100, 3, 42),
          side: const BorderSide(color: Color.fromARGB(255, 100, 3, 42)),
        ),
      ),
    );
  }
}

//class _LesInfosDesText extends State<CreaGroupe> {
  // Step 1: Initialize a TextEditingController
 // final TextEditingController _controller = TextEditingController();
//}




