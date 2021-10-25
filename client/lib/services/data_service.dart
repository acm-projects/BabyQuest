import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static final _database = FirebaseFirestore.instance;
  static final _userCollection = _database.collection('users');
  static final _profileCollection = _database.collection('profiles');

  static dynamic _userListener;
  static dynamic _profileListener;

  // default UserData
  static const _defaultUserData = {
    'profiles': [],
    'shared_profiles': [],
    'to_do_list': [],
  };

  static updateUserData(String uid, Map<String, dynamic> fields) async {
    DocumentReference userDocument = _userCollection.doc(uid);
    await userDocument.update(fields);
  }

  // sets data sync for user data with database
  static setUserDataSync(String uid, Function update) async {
    DocumentReference userDocument = _userCollection.doc(uid);

    // If user data doesn't exist yet, create it
    await userDocument.get().then((document) {
      if (!document.exists) {
        userDocument.set(_defaultUserData);
      }
    });

    _userListener = userDocument.snapshots().listen((document) {
      update(document.data() as Map<String, dynamic>);
    });
  }

  // removes data sync for user data with database
  static removeUserDataSync(String uid) {
    if (_userListener != null) {
      _userListener.cancal();
    }

    if (_userListener == null) return;

    _userListener.cancel();
    _userListener = null;
  }

  static createProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required int gender,
    required double height,
    required double weight,
    required String pediatrician,
    required String pediatricianPhone,
    required Map<String, int> allergies,
  }) async {
    String documentId = '';

    await _profileCollection.add({
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate.toString(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'pediatrician': pediatrician,
      'pediatrician_phone': pediatricianPhone,
      'allergies': allergies,
    }).then((document) {
      documentId = document.id;
    });

    return documentId;
  }

  // retrieves profile data from the database, or creates it if not yet created
  static Future<Map<String, dynamic>> getProfileData(String uid) async {
    Map<String, dynamic> profileData = {};

    DocumentReference profileDocument = _profileCollection.doc(uid);
    await profileDocument.get().then((document) {
      if (document.exists) {
        profileData = document.data() as Map<String, dynamic>;
      }
    });

    return profileData;
  }

  // sets data sync for profile data with database
  static setProfileDataSync(String uid, Function update) {
    if (_profileListener != null) {
      _profileListener.cancal();
    }

    DocumentReference profileDocument = _profileCollection.doc(uid);

    _profileListener = profileDocument.snapshots().listen((document) {
      update(document.data() as Map<String, dynamic>);
    });
  }

  // removes data sync for profile data with database
  static removeProfileDataSync(String uid) {
    if (_profileListener == null) return;

    _profileListener.cancel();
    _profileListener = null;
  }

  // retrieves the current qod data from local storage or api
  static Future getQOD() async {
    final preferences = await SharedPreferences.getInstance();

    DateTime now = DateTime.now();
    String today = DateTime(now.year, now.month, now.day).toString();

    // [0] = date, [1] = message, [2] = author, [3] = imageUrl
    List<String> qod = preferences.getStringList('qod') ?? [];

    if (qod.isEmpty || qod[0] != today) {
      // fetch qod from api
      var response = await http
          .get(Uri.parse('http://quotes.rest/qod.json?category=inspire'));

      if (response.statusCode == 200) {
        Map<String, dynamic> qodData =
            jsonDecode(response.body)['contents']['quotes'][0];
        qod = [
          today,
          qodData['quote'],
          qodData['author'],
          qodData['background']
        ];
      }

      preferences.setStringList('qod', qod);
    }

    return qod;
  }
}
