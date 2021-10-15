import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static Future getQOD() async {
    final preferences = await SharedPreferences.getInstance();
    
    DateTime now = DateTime.now();
    String today = DateTime(now.year, now.month, now.day).toString();

    // [0] = date, [1] = message, [2] = author, [3] = imageUrl
    List<String> qodData = preferences.getStringList('qod') ?? [];

    if (qodData.isEmpty || qodData[0] != today) {
      // fetch qod and save to qodData
      preferences.setStringList('qod', qodData);
    }

    return qodData;
  }


















  Future getQOD1() async {
    final preferences = await SharedPreferences.getInstance();
    final lastAccessedKey = 'last_accessed';
    final qodMessageKey = 'qod_message';
    final qodAuthorKey = 'qod_author';
    final qodImageKey = 'qod_image';

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final lastAccessed = DateTime.parse(preferences.getString(lastAccessedKey) ?? yesterday.toString());

    String? message = null;
    String? author = null;
    String? image = null;

    if (lastAccessed == DateTime.now()) {
      message = preferences.getString(qodMessageKey);
      author = preferences.getString(qodAuthorKey);
      image = preferences.getString(qodImageKey);
    }

    message ??= '';
    author ??= '';
    image ??= '';
  }

















  static final _database = FirebaseFirestore.instance;
  static final _userCollection = _database.collection('users');
  static final _profileCollection = _database.collection('profiles');

  static final Map<String, dynamic> _userListeners = {};
  static final Map<String, dynamic> _profileListeners = {};

  // default UserData
  static const _defaultUserData = {
    'profiles': [],
    'sharedProfiles': [],
  };

  // default ProfileData
  static const _defaultProfileData = {
    'firstName': '',
    'lastName': '',
    'birthDate': '',
  };

  // retrieves user data from the database, or creates it if not yet created
  static Future<Map<String, dynamic>> getUserData(String uid) async {
    Map<String, dynamic> userData = _defaultUserData;

    DocumentReference userDocument = _userCollection.doc(uid);
    await userDocument.get().then((document) {
      if (!document.exists) {
        // userData doesn't yet exist, so create it here
        userDocument.set(_defaultUserData);
      } else {
        userData = document.data() as Map<String, dynamic>;
      }
    });

    return userData;
  }

  // sets data sync for user data with database
  static setUserDataSync(String uid, Function update) {
    DocumentReference userDocument = _userCollection.doc(uid);

    _userListeners[uid] = userDocument.snapshots().listen((document) {
      update(document.data() as Map<String, dynamic>);
    });
  }

  // removes data sync for user data with database
  static removeUserDataSync(String uid) {
    if (_userListeners[uid] == null) return;

    _userListeners[uid].cancel();
    _userListeners[uid] = null;
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
    DocumentReference profileDocument = _profileCollection.doc(uid);

    _profileListeners[uid] = profileDocument.snapshots().listen((document) {
      update(document.data() as Map<String, dynamic>);
    });
  }

  // removes data sync for profile data with database
  static removeProfileDataSync(String uid) {
    if (_profileListeners[uid] == null) return;

    _profileListeners[uid].cancel();
    _profileListeners[uid] = null;
  }
}
