import 'package:client/models/baby_profile.dart';
import 'package:client/services/data_service.dart';

class AppUser {
  static AppUser? _currentUser;

  // private properties
  bool _isLoaded = false;
  String? _lastProfile;
  List<String>? _profiles;
  List<String>? _sharedProfiles;
  Map<String, String>? _profileNames;
  List<String>? _toDoList;

  // public properties
  final String uid;
  final String email;

  // static accessors
  static AppUser? get currentUser => _currentUser;

  static set currentUser(AppUser? user) {
    if (user?.uid == currentUser?.uid) return;
    if (currentUser != null) currentUser!._removeDataSync();
    if (user != null) user._setDataSync();

    _currentUser = user;
  }

  // public accessors
  bool get isLoaded => _isLoaded;
  List<String> get ownedProfiles => _profiles ?? [];
  List<String> get sharedProfiles => _sharedProfiles ?? [];
  Map<String, String> get profileNames => _profileNames ?? {};
  List<String> get toDoList => _toDoList ?? [];

  AppUser(this.uid, this.email);

  // private methods
  void _setDataSync() async {
    DataService.setUserDataSync(uid, email, _updateData);
  }

  void _removeDataSync() async {
    DataService.removeUserDataSync(uid);
  }

  Future _updateData(Map<String, dynamic> userData) async {
    _lastProfile = userData['last_profile'] as String?;
    _profiles =
        (userData['profiles'] as List).map((item) => item as String).toList();
    _sharedProfiles = (userData['shared_profiles'] as List)
        .map((item) => item as String)
        .toList();
    _profileNames = await DataService.getProfileNames(ownedProfiles, sharedProfiles);
    _toDoList =
        (userData['to_do_list'] as List).map((item) => item as String).toList();

    if (_lastProfile != null &&
        (ownedProfiles.contains(_lastProfile) ||
            sharedProfiles.contains(_lastProfile))) {
      setCurrentProfile(_lastProfile!);
    } else if (ownedProfiles.isNotEmpty) {
      setCurrentProfile(ownedProfiles[0]);
    }

    _isLoaded = true;
  }

  // Switches the currently displayed BabyProfile based on the provided uid
  void setCurrentProfile(String profileUid) {
    if (this != _currentUser) return;

    BabyProfile.currentProfile = BabyProfile(profileUid);

    if (_lastProfile != profileUid) {
      DataService.updateUserData(uid, {'last_profile': profileUid});
    }
  }

  void createNewProfile({
    required String name,
    required DateTime birthDate,
    required int gender,
    required double height,
    required double weightLb,
    required double weightOz,
    required String pediatrician,
    required String pediatricianPhone,
    required Map<String, int> allergies,
    required String imagePath,
  }) async {
    String profileId = await DataService.createProfile(
      name: name,
      birthDate: birthDate,
      gender: gender,
      height: height,
      weightLb: weightLb,
      weightOz: weightOz,
      pediatrician: pediatrician,
      pediatricianPhone: pediatricianPhone,
      allergies: allergies,
      imagePath: imagePath,
    );

    List<String> newProfiles = ownedProfiles;
    newProfiles.add(profileId);
    await DataService.updateUserData(uid, {'profiles': newProfiles});

    setCurrentProfile(profileId);
  }
}
