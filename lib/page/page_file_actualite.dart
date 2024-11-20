import 'package:flutter/material.dart';
import 'package:comunique2024/widget/filter_homeScreen.dart';
import 'package:comunique2024/widget/card_home.dart';

class FileActualite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Filter(),
          ),
          Expanded(
            child: ListView(
              children: const [
                CardHome(
                  office: "JE",
                  role: "Présidente i2c",
                  eventTitle: 'Formation i2c',
                  eventDate: 'Le jeudi 16 novembre 2023',
                  eventTime: 'De 12h30 à 14h',
                  eventLocation: 'Salle S103',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(187, 208, 143, 0.71),
                  price: '0',
                  capacity: '20',
                  moreInfo: '',
                ),
                CardHome(
                  office: "BDS",
                  role: "Respo WES",
                  eventTitle: 'WES',
                  eventDate: 'Du 12 au 14 janvier 2024',
                  eventTime: '',
                  eventLocation: 'Station Pas de la Case, Andorre',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(167, 222, 219, 0.71),
                  price: '149€ à 259€',
                  capacity: '50 places au total',
                  moreInfo:
                      'Option 1 :  Forfait 3 jours\n-> 259€ (non adhérent BDS)\n-> 229€ (adhérent BDS)\n\nOption 2 : Forfait 2 jours\n-> 229€ (non adhérent BDS)\n-> 199€ (adhérent BDS)\n\nOption 3 : Sans forfait (peu de place)\n-> 179€ (non adhérent BDS)\n-> 149€ (adhérent BDS)',
                ),
                CardHome(
                  office: "BDA",
                  role: "Club musique",
                  eventTitle: 'Répétition',
                  eventDate: 'Le mardi 21 septembre 2023',
                  eventTime: 'De 12h30 à 13h30',
                  eventLocation: 'Salle S103',
                  imageUrl: 'https://via.placeholder.com/150',
                  color: Color.fromRGBO(245, 233, 171, 0.71),
                  price: '0',
                  capacity: '10',
                  moreInfo: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
