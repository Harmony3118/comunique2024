import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  @override
  _Header createState() => _Header();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _Header extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("COM'UNIQUE",
          style: TextStyle(
            color: Color.fromARGB(255, 100, 3, 41),
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          color: const Color.fromARGB(255, 59, 58, 58),
          onPressed: () {
            // A ajouter...
          },
        ),
      ],
      elevation: 0.0, // supprime l'ombre
    );
  }
}

class Footer extends StatefulWidget {
  final int currentIndex;
  final Function(int) changePage;

  Footer({Key? key, required this.currentIndex, required this.changePage})
      : super(key: key);

  @override
  _Footer createState() =>
      _Footer(currentIndex: currentIndex, changePage: changePage);
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

          // A ajouter ...
        });
      },
      items: [
        _buildIcon(0, Icons.home),
        _buildIcon(1, Icons.calendar_today),
        _buildIcon(2, Icons.add_circle),
        _buildIcon(3, Icons.contacts),
        _buildIcon(4, Icons.mail),
      ],
    );
  }

  BottomNavigationBarItem _buildIcon(int index, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: this.currentIndex == index
            ? Color.fromARGB(255, 100, 3, 41)
            : Color.fromARGB(255, 59, 58, 58),
      ),
      label: '',
    );
  }
}
