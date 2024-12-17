import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page_connection.dart';

Future<void> saveUserSession(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', userId); // Sauvegarder l'ID utilisateur
}

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(
      'user_id'); // Retourne l'ID utilisateur ou null s'il n'est pas connecté
}

Future<void> logoutUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id'); // Supprimer l'ID utilisateur
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => PageConnection()),
  );
}

// // Requête pour obtenir les infos de l'utilisateur
// Future<Map<String, dynamic>?> getUserDetails(int userId) async {
//   final db = await database; // Accès à la base de données SQFLite
//   final result = await db.query(
//     'utilisateur',
//     where: 'id = ?',
//     whereArgs: [userId],
//   );

//   if (result.isNotEmpty) {
//     return result.first; // Retourne les informations de l'utilisateur
//   }
//   return null; // Si aucune donnée n'est trouvée
// }

// // Charger les informations utilisateur dans l'application
// void loadUserDetails() async {
//   final userId = await getUserId(); // Récupérer l'ID depuis shared_preferences
//   if (userId != null) {
//     final userDetails =
//         await getUserDetails(userId); // Charger les infos depuis la BDD
//     if (userDetails != null) {
//       print("Nom : ${userDetails['nom']}");
//       print("Prénom : ${userDetails['prenom']}");
//     }
//   } else {
//     print("Aucun utilisateur connecté.");
//   }
// }
