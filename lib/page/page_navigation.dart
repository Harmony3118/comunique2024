import 'package:comunique2024/page/page_annuaire.dart';
import 'package:comunique2024/page/page_contactAdmin.dart';
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
      if (currentIndex == 3) {
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
      bottomNavigationBar: Footer(currentIndex: currentIndex),
    );
  }
  //     bottomNavigationBar:
  //         Footer(currentIndex: currentIndex, changePage: changePage),
}
