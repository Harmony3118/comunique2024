import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_file_actualite.dart';
import 'package:comunique2024/page/page_contact_admin.dart';
import 'package:comunique2024/page/page_header_footer.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final int currentIndex;
  final Widget body;

  BasePage({Key? key, required this.currentIndex, required this.body})
      : super(key: key);

  @override
  _BasePageState createState() =>
      _BasePageState(currentIndex: currentIndex, body: body);
}

class _BasePageState extends State<BasePage> {
  int currentIndex;
  Widget body;

  _BasePageState({required this.currentIndex, required this.body});

  void changePage(int newCurrentIndex) {
    setState(() {
      currentIndex = newCurrentIndex;
      if (currentIndex == 0) {
        body = FileActualite();
      } else if (currentIndex == 1) {
        print("Calendrier pas encore codé");
        // body = Calendrier();
      } else if (currentIndex == 2) {
        print("PageAjout pas encore codé");
        // body = PageAjout();
      } else if (currentIndex == 3) {
        body = const AnnuairePage();
      } else if (currentIndex == 4) {
        body = const ContactPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: body,
      bottomNavigationBar:
          Footer(currentIndex: currentIndex, changePage: changePage),
    );
  }
  //     bottomNavigationBar:
  //         Footer(currentIndex: currentIndex, changePage: changePage),
}
