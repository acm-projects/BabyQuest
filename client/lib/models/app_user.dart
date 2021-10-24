import 'package:client/models/baby_profile.dart';
import 'package:client/services/data_service.dart';

class AppUser {
  static AppUser? _currentUser;

  // private properties
  Map<String, String>? _profiles;
  Map<String, String>? _sharedProfiles;
  List<String> _toDoList;

  // public properties
  final String uid;

  // static accessors
  static AppUser? get currentUser => _currentUser;

  static set currentUser(AppUser? user) {
    if (user == currentUser) return;
    if (currentUser != null) currentUser!._removeDataSync();
    if (user != null) user._setDataSync();

    _currentUser = user;
  }

  // public accessors
  Map<String, String> get ownedProfiles {
    return _profiles ?? {};
  }

  Map<String, String> get sharedProfiles {
    return _sharedProfiles ?? {};
  }

  AppUser(this.uid);

  void _setDataSync() async {
    DataService.setUserDataSync(uid, _updateData);
  }

  void _removeDataSync() async {
    DataService.removeUserDataSync(uid);
  }

  Future _updateData(Map<String, dynamic> userData) async {
    List<String> profiles = (userData['profiles'] as List).map((item) => item as String).toList();
    List<String> sharedProfiles = (userData['sharedProfiles'] as List).map((item) => item as String).toList();

    _profiles = await DataService.getProfileNames(profiles);
    _sharedProfiles = await DataService.getProfileNames(sharedProfiles);
  }

  // Switches the currently displayed BabyProfile based on the provided uid
  void setCurrentProfile(String uid) {
    if (this != _currentUser) return;
    
    BabyProfile.currentProfile = BabyProfile(uid);
  }
}
