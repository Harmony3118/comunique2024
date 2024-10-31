import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _clientId = '270875634573-cmpg059hdoja3dddtk444apgmu9uodkn.apps.googleusercontent.com';
const _clientSecret = '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';


class UserSheetApi {
  static const _credentials = r'''{
  "type": "service_account",
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
}
'''; // identifiant du sheet sur google cloud
  static final _spreadsheetId = '1rjb2eNrdx5glgy5apVLNLBYon0tJAtrWyns9nIJiUrQ'; // clée dans le lien du sheet 
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'inscription');// ici le nom de la feuille que je récupère 

    final firstRow = UserFields.getFields();
    _userSheet!.values.insertRow(1, firstRow );
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
      required String title,
    }) async {
      try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
}


class UserFields {
  static final String prenom = 'prenom';
  static final String nom = 'nom';

  static List<String> getFields() => [nom , prenom];
}


class User {
  final String prenom;
  final String nom;

  const User({
    required this.prenom,
    required this.nom,
  });

  Map<String, dynamic> toJson() => {
    UserFields.nom: nom,
    UserFields.prenom: prenom,
  };
}

class UserRegistration {
  final String nom;
  final String prenom;

  UserRegistration({required this.nom, required this.prenom});

  Future<void> inscrire() async {
    final user = User(
      prenom: prenom,
      nom: nom,
    );
    await UserSheetApi.insert([user.toJson()]);
  }
}

// pour appliquer la page sur le bouton on l'appelle ainsi :
// onPressed: () async {
//                 UserRegistration registration = UserRegistration(nom: 'Prudhommeaux', prenom: 'Erwan');// ici a mettre les variables du nom et du prenom 
//                 await registration.inscrire();
//               },