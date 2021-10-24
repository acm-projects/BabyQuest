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
    'sharedProfiles': [],
    'toDoList': [],
  };

  // default ProfileData
  static const _defaultProfileData = {
    'firstName': '',
    'lastName': '',
    'birthDate': '',
    //***
  };

  // sets data sync for user data with database
  static setUserDataSync(String uid, Function update) async{
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

  static Future<String> getProfileName(String uid) async {
    Map<String, dynamic> profileData = await getProfileData(uid);
    String firstName = profileData['firstName'] as String;
    String lastName = profileData['lastName'] as String;

    return firstName + ' ' + lastName;
  }

  // retrieves profile names and returns them as a map
  static Future<Map<String, String>> getProfileNames(List<String>? profiles) async {
    List<String> uids = profiles ?? [];
    Map<String, String> profileNames = {};

    for (String uid in uids) {
      profileNames[uid] = await getProfileName(uid);
    }

    return profileNames;
  }

  // retrieves profile data from the database, or creates it if not yet created
  static Future<Map<String, dynamic>> getProfileData(String uid) async {
    Map<String, dynamic> profileData = _defaultProfileData;

    DocumentReference profileDocument = _profileCollection.doc(uid);
    await profileDocument.get().then((document) {
      if (!document.exists) {
        // profileData doesn't yet exist, so create i here
        profileDocument.set(_defaultProfileData);
      } else {
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
      var response = await http.get(Uri.parse('http://quotes.rest/qod.json?category=inspire'));

      if (response.statusCode == 200) {
        Map<String, dynamic> qodData = jsonDecode(response.body)['contents']['quotes'][0];
        qod = [today, qodData['quote'], qodData['author'], qodData['background']];
      }

      preferences.setStringList('qod', qod);
    }

    return qod;
  }
}
