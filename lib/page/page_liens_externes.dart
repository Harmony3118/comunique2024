import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LienPage extends StatelessWidget {
  final Uri url1 = Uri.parse("https://moodle.bordeaux-inp.fr/");
  final Uri url2 = Uri.parse("https://www.bordeaux-inp.fr/fr");

  // Function to launch URLs
  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              const Center(
                child: Text(
                  "Mes Liens",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(thickness: 1, color: Colors.black),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height *
                    0.8, // 80% of screen height
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center images vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center images horizontally
                  children: [
                    GestureDetector(
                      onTap: () => _launchURL(url1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://s3-alpha-sig.figma.com/img/84e0/0b42/f99be8bc653bcdaf0e44c81879958e95?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=O5Hvq5adLW65L9UOJHOVSRnelDqGKrcWvXLwWbKJH40lvOG81vGJEBFNt8arvA-lgZk0S8OMj4WIjSv9UhQotglHkJU2uW-SX0qsRDhsbZjEfZRjAvOk-uHFMTDEYGxceLBAeocIs0-sq-ei3maaYq2bdJrDa06hZL1UsixNL~2TLEtdCmlqsF05vNTvUENLaglG1SoYzjc7-AgBQzEHYqgAhCMw4pil24C5K-zjiNnOfacRRHf6IHs23zx6jk7GcpCvxh-6T6PW9CUhpWwAHka02LJAm8RopxsEDOBFf0i70~gozyFPuiw6752DLJcFz1w5r4CJnseYYLojZANapw__',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Diviseur(),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _launchURL(url2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://s3-alpha-sig.figma.com/img/4479/87a0/c4efc8abd9a65349f22f00cbba2a9afb?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZMfNHe9FcykO79upmia1IMRdh2ObfK36kIUBaBdQEitTbfBPTa3khShMgudgHzYNkam3vYe92jocC4-Fpp66N08V7JxHv8Ppouc0VUAuOiWEbY0aDvYAbE8x1ZUkmJndLZGNZJaVWKCKt0tiKH6mT2Dq1gzcjTqRXPJOlUPl8SC7c41ISiBWZmdYdu5sZizF8j~pbC4-Pdidzzm3uOTLaeBL1qrk2fUtBQxTOM6Bdu~UjX7IVAL~NbaXiW6lrkb1yCIqiAfZFG2aTxe9TmFdKXZKPwsjcTwH23pDsVTdDqi3FVMFCW7Dhj7E8PgqFrTyTVWbN-OB9N~2CMwLujXFcA__',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Diviseur(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// je l'utilise aussi dans page_for_crea_groupe donc c'est peut etre mieux d'importer

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
