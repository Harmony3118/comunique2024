import 'package:flutter/material.dart';
import 'conservationUtilisateur.dart';
import 'page_navigation.dart';
import 'page_parametre.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  @override
  _Header createState() => _Header();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

// icon logout
class _Header extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Supprime l'icône de retour
      title: Text("COM'UNIQUE",
          style: TextStyle(
            color: Color.fromARGB(255, 100, 3, 41),
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.settings),
        color: const Color.fromARGB(255, 59, 58, 58),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BasePage(currentIndex: 0, body: Pageparametre()),
              ));
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.logout),
            color: const Color.fromARGB(255, 59, 58, 58),
            onPressed: () {
              logoutUser(context);
            })
      ],
      elevation: 0.0, // supprime l'ombre
    );
  }
}

class Footer extends StatefulWidget {
  final int currentIndex;
  final Function(int) changePage;

  Footer({
    Key? key,
    this.currentIndex = 0, // Valeur par défaut pour currentIndex
    this.changePage = _defaultChangePage, // Valeur par défaut pour changePage
  }) : super(key: key);

  // Footer({Key? key, required this.currentIndex, required this.changePage})
  //     : super(key: key);

  @override
  _Footer createState() =>
      _Footer(currentIndex: currentIndex, changePage: changePage);

  // Fonction par défaut qui ne fait rien
  static void _defaultChangePage(int index) {}
}

class _Footer extends State<Footer> {
  int currentIndex;
  Function(int) changePage;

  _Footer({required this.currentIndex, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (newIndex) {
        setState(() {
          currentIndex = newIndex;
          changePage(newIndex);
        });
      },
      items: [
        _buildIcon(0, Icons.home, "Accueil"),
        _buildIcon(1, Icons.calendar_today, "Calendrier"),
        _buildIcon(2, Icons.add_circle, "Ajout"),
        _buildIcon(3, Icons.contacts, "Annuaire"),
        _buildIcon(4, Icons.mail, "Mails"),
      ],
    );
  }

  BottomNavigationBarItem _buildIcon(int index, IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Tooltip(
        message:
            label, // Le texte à afficher quand l'utilisateur appuie longuement
        child: Icon(
          icon,
          color: this.currentIndex == index
              ? Color.fromARGB(255, 100, 3, 41)
              : Color.fromARGB(255, 59, 58, 58),
        ),
      ),
      label: '',
    );
  }
}
