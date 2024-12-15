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
      throw 'Impossible d’ouvrir le lien $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 51, 51, 51)),
                  onPressed: () => Navigator.pop(context),
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
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.8,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Moodle-logo.svg/1200px-Moodle-logo.svg.png',
                              height: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  color: Colors.red,
                                  size: 50,
                                );
                              },
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
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIfhtLpjaia-dLUh_qUwBu3v65_cnJyhwIwg&s',
                              height: 300,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  color: Colors.red,
                                  size: 50,
                                );
                              },
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
          ],
        ),
      ),
    );
  }
}

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