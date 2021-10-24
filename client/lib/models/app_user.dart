import 'package:client/models/baby_profile.dart';
import 'package:client/services/data_service.dart';

class AppUser {
  static AppUser? _currentUser;

  // private properties
  List<String>? _profiles;
  List<String>? _sharedProfiles;
  List<String>? _toDoList;

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
  List<String> get ownedProfiles {
    return _profiles ?? [];
  }

  List<String> get sharedProfiles {
    return _sharedProfiles ?? [];
  }

  AppUser(this.uid);

  // private methods
  void _setDataSync() async {
    DataService.setUserDataSync(uid, _updateData);
  }

  void _removeDataSync() async {
    DataService.removeUserDataSync(uid);
  }

  Future _updateData(Map<String, dynamic> userData) async {
    _profiles =
        (userData['profiles'] as List).map((item) => item as String).toList();
    _sharedProfiles = (userData['shared_profiles'] as List)
        .map((item) => item as String)
        .toList();
    _toDoList =
        (userData['to_do_list'] as List).map((item) => item as String).toList();

    // TEMPORARY: assumes every user has only 1 profile
    if (ownedProfiles.length == 1) {
      setCurrentProfile(ownedProfiles[0]);
    }
  }

  // public methods

  // Switches the currently displayed BabyProfile based on the provided uid
  void setCurrentProfile(String uid) {
    if (this != _currentUser) return;

    BabyProfile.currentProfile = BabyProfile(uid);
  }

  void createNewProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required int gender,
    required double height,
    required double weight,
    required String pediatrician,
    required String pediatricianNumber,
    required Map<String, int> allergies,
  }) async {
    String profileId = await DataService.createProfile(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      height: height,
      weight: weight,
      pediatrician: pediatrician,
      pediatricianNumber: pediatricianNumber,
      allergies: allergies,
    );

  }
}
