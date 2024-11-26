import 'package:gsheets/gsheets.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'dart:convert';


// class UserSheetApi {
//   static const _credentials = r'''{"type": "service_account",
//   "project_id": "linen-setting-439422-t1",
//   "private_key_id": "e5ab35b27736a538e1cd9d983afb1ba5e6b43116",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDdn8dNNlY7zn7i\nZ3HOkKYE/8jSR1CVF0/S8Yz6BiLQjrPG1UpM5UhCgROB8OSNs4099z+KFB0rNYVX\nXSNA3WruzsBZ7+5ZyyROxg43hriaAAo+xdhhYEqMLlbUjPO6WV7E7GT+k72FqTx4\nO9jRk7xLLhOGaVMPivtP61Ij96k1xuahjvNnF6RkiQqCu0p6nYZ8JDlt3K7Fc6iP\nsq04hxByjJYt+Yrl4V899WHHpjbeuQGmhiCKiRz6MAgEiVNfq3kSrDbjN6nyaPhD\n8yzkJFt1zr+NDAKmqLvyMfRBRc1FCeXaKdVAiQGkrYF4ILeeVl5DNSU9IiPW8C0d\nIIsB7+dpAgMBAAECggEAAXQlOKWO+H604JuM2K3kduMuICn5VncEDiZJNlEgvJU5\nCuh2f61f1VbXJ8qqlx7awfGrnCZgYBqOZLmuy+O/6i/XPWfIXJSraOxd5sGWl6UB\nLDL8Rbw91PBPX77KcPoZ1+kUiwJxU21+IOxEknBZg3U6ic7KTY9r8VTh8awz0w9X\nLpB+fVEKC0NY7oGIWCTd1UnmUAG1ZM8QUjeoOQnbuXZsVSdemOebUWQcfrTWJFkK\nG6n1I2defXuF7FvXP4tz3sS4XuaASKqdFwrD1aK2V9mRUh9CBS72Z/DtTWwu4ueI\nBPx3pevW41jwumYNBW0xLySBInUJ1m/p1Sll+nVQAQKBgQD4LT8Axy+ZTF9eK1oY\nB7juzZbSynp0dS+bfojci+b8eRZG/Jol1XxkeOA6F7Z0v839d5pPA/tKPtX96OHg\nykEBejYDGFC34V4l4wGJMgfVSpafyw3wGzdSih57Toi8r7le1JazhBiIAbpRq+7/\nJH49rgrYtLbCUcnLBy8d7HtwAQKBgQDknEGfg2DxYaAj+swbo6yzlDXypEOxLypK\nr1yedaPd430hg+GEBEnAL8wycNZQyZNtK/qZ2jhtzgc+XGiheYeyyvPsaDI+arq4\nYXoWZJdc92MyoIWeJ7QOkogy1zRIb4xGGXVGk24h1avnBDr/uo3+SiqBjqTSdeOZ\nM4HUyj73aQKBgD6oHbnyj//iGknKJCrg+D3CRgvd9uCkHWrinWchIyYm5Ar0B275\n4Tf0lJfWGMiNDFKr+ZdtZ+osxxYdz7lTFupqkmxhnS9vhLeIAoFC0lt1Q2YAe/pc\nxLDgEiYLg9Yvf1uDzLBx70eXOBUalXJxIjYsVKy1o1aYE5xgqfKiG+ABAoGAUzO7\nfn6mTbOmQPIKTxTmygTrDYBTUq1DyyK/prxSA3PEGuqQrSeSX+wFeWYv2f9DNLyI\n3G3bk7skT8H6IqrEhIHw/N1/S9A0XN69PGEn5aHz7H0XpFP26EbUYwyH7sUKXIjv\ncdw+fPnzMoULo/8VprL/fV+ZBS/6wctJOVTSTeECgYByJT36yVeLT7G4MNVq8SVz\nKqKi2rI57kXzaqq96FwjZ6V8CKVnoHpHgcievot1X2caIEcTWvnDtOQCOKtLWGmR\nuS6TuEaKyPxjYGAS+ozT+HE1tT/B0CvBHMo9P6ElKE2x8EPVn64a8VmUbIY+TF3N\naVAeYRpZOvNLHK2cL/nSrg==\n-----END PRIVATE KEY-----\n",
//   "client_email": "inscription@linen-setting-439422-t1.iam.gserviceaccount.com",
//   "client_id": "103545755138568989064",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/inscription%40linen-setting-439422-t1.iam.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
// }'''; 
//   static final _spreadsheetId = '1rjb2eNrdx5glgy5apVLNLBYon0tJAtrWyns9nIJiUrQ'; // L'ID du Google Sheet
//   static final _gsheets = GSheets(_credentials);
//   static Spreadsheet? _spreadsheet;

//   static Future init() async {
//     try {
//       _spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
//       print("Spreadsheet initialized successfully.");
//     } catch (e) {
//       print("Init Error: $e");
//     }
//   }

//   static Future<Worksheet?> addNewSheet(String sheetName) async {
//     if (_spreadsheet == null) {
//       print("Spreadsheet not initialized.");
//       return null;
//     }

//     try {
//       // Vérifie si une feuille avec ce nom existe déjà
//       final existingSheet = _spreadsheet!.worksheetByTitle(sheetName);
//       if (existingSheet != null) {
//         print("Worksheet '$sheetName' already exists.");
//         return existingSheet;
//       }

//       // Crée une nouvelle feuille
//       final newSheet = await _spreadsheet!.addWorksheet(sheetName);
//       print("Worksheet '$sheetName' created successfully.");
//       return newSheet;
//     } catch (e) {
//       print("Error while creating worksheet: $e");
//       return null;
//     }
//   }
// }


class GoogleSheetService {
  // Informations d'authentification et ID de la feuille Google
  final String _spreadsheetId = '1rjb2eNrdx5glgy5apVLNLBYon0tJAtrWyns9nIJiUrQ';  // Remplace par l'ID de ton sheet
  static final _credentials = ServiceAccountCredentials.fromJson(json.decode(r'''{"type": "service_account",
    "project_id": "linen-setting-439422-t1",
    "private_key_id": "e5ab35b27736a538e1cd9d983afb1ba5e6b43116",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDdn8dNNlY7zn7i\nZ3HOkKYE/8jSR1CVF0/S8Yz6BiLQjrPG1UpM5UhCgROB8OSNs4099z+KFB0rNYVX\nXSNA3WruzsBZ7+5ZyyROxg43hriaAAo+xdhhYEqMLlbUjPO6WV7E7GT+k72FqTx4\nO9jRk7xLLhOGaVMPivtP61Ij96k1xuahjvNnF6RkiQqCu0p6nYZ8JDlt3K7Fc6iP\nsq04hxByjJYt+Yrl4V899WHHpjbeuQGmhiCKiRz6MAgEiVNfq3kSrDbjN6nyaPhD\n8yzkJFt1zr+NDAKmqLvyMfRBRc1FCeXaKdVAiQGkrYF4ILeeVl5DNSU9IiPW8C0d\nIIsB7+dpAgMBAAECggEAAXQlOKWO+H604JuM2K3kduMuICn5VncEDiZJNlEgvJU5\nCuh2f61f1VbXJ8qqlx7awfGrnCZgYBqOZLmuy+O/6i/XPWfIXJSraOxd5sGWl6UB\nLDL8Rbw91PBPX77KcPoZ1+kUiwJxU21+IOxEknBZg3U6ic7KTY9r8VTh8awz0w9X\nLpB+fVEKC0NY7oGIWCTd1UnmUAG1ZM8QUjeoOQnbuXZsVSdemOebUWQcfrTWJFkK\nG6n1I2defXuF7FvXP4tz3sS4XuaASKqdFwrD1aK2V9mRUh9CBS72Z/DtTWwu4ueI\nBPx3pevW41jwumYNBW0xLySBInUJ1m/p1Sll+nVQAQKBgQD4LT8Axy+ZTF9eK1oY\nB7juzZbSynp0dS+bfojci+b8eRZG/Jol1XxkeOA6F7Z0v839d5pPA/tKPtX96OHg\nykEBejYDGFC34V4l4wGJMgfVSpafyw3wGzdSih57Toi8r7le1JazhBiIAbpRq+7/\nJH49rgrYtLbCUcnLBy8d7HtwAQKBgQDknEGfg2DxYaAj+swbo6yzlDXypEOxLypK\nr1yedaPd430hg+GEBEnAL8wycNZQyZNtK/qZ2jhtzgc+XGiheYeyyvPsaDI+arq4\nYXoWZJdc92MyoIWeJ7QOkogy1zRIb4xGGXVGk24h1avnBDr/uo3+SiqBjqTSdeOZ\nM4HUyj73aQKBgD6oHbnyj//iGknKJCrg+D3CRgvd9uCkHWrinWchIyYm5Ar0B275\n4Tf0lJfWGMiNDFKr+ZdtZ+osxxYdz7lTFupqkmxhnS9vhLeIAoFC0lt1Q2YAe/pc\nxLDgEiYLg9Yvf1uDzLBx70eXOBUalXJxIjYsVKy1o1aYE5xgqfKiG+ABAoGAUzO7\nfn6mTbOmQPIKTxTmygTrDYBTUq1DyyK/prxSA3PEGuqQrSeSX+wFeWYv2f9DNLyI\n3G3bk7skT8H6IqrEhIHw/N1/S9A0XN69PGEn5aHz7H0XpFP26EbUYwyH7sUKXIjv\ncdw+fPnzMoULo/8VprL/fV+ZBS/6wctJOVTSTeECgYByJT36yVeLT7G4MNVq8SVz\nKqKi2rI57kXzaqq96FwjZ6V8CKVnoHpHgcievot1X2caIEcTWvnDtOQCOKtLWGmR\nuS6TuEaKyPxjYGAS+ozT+HE1tT/B0CvBHMo9P6ElKE2x8EPVn64a8VmUbIY+TF3N\naVAeYRpZOvNLHK2cL/nSrg==\n-----END PRIVATE KEY-----\n",
    "client_email": "inscription@linen-setting-439422-t1.iam.gserviceaccount.com",
    "client_id": "103545755138568989064",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/inscription%40linen-setting-439422-t1.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }''')); 
    static final _gsheets = GSheets(_credentials);


  // Les scopes requis pour l'API Sheets
  static const _scopes = [sheets.SheetsApi.spreadsheetsScope];

  // Fonction pour authentifier l'utilisateur via un compte de service
  Future<SheetsApi> _authenticate() async {
    try {
      // Authentification avec le service account
      final client = await clientViaServiceAccount(_credentials, _scopes);
      return SheetsApi(client);
    } catch (e) {
      print("Erreur d'authentification : $e");
      rethrow;
    }
  }

  // Fonction pour créer une nouvelle feuille dans le Google Sheets
  Future<void> createSheet(String sheetTitle) async {
    try {
      // Authentifier et obtenir l'instance de l'API Sheets
      final sheetsApi = await _authenticate();

      // Créer la requête pour ajouter une feuille
      var request = BatchUpdateSpreadsheetRequest.fromJson({
        "requests": [
          {
            "addSheet": {
              "properties": {
                "title": sheetTitle,
              }
            }
          }
        ]
      });

      // Envoie la requête pour ajouter la feuille
      final response = await sheetsApi.spreadsheets.batchUpdate(request, _spreadsheetId);
      print("Feuille '$sheetTitle' créée avec succès.");
    } catch (e) {
      print("Erreur lors de la création de la feuille: $e");
    }
  }
}