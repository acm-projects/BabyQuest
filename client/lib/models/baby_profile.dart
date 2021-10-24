import 'package:client/services/data_service.dart';

class BabyProfile {
  static BabyProfile? _currentProfile;

  // private properties
  String? _firstName;
  String? _lastName;
  DateTime? _birthDate;
  int? gender;
  double? height;
  double? weight;
  Map<String, int>? allergies;
  String? pediatrician;
  String? pediatricianPhone;
  String? profilePic;
  Map<String, int> diaperChanges;
  List<Map<DateTime, DateTime>>? sleep;
  Map<String, int>? feedings;

  // public properties
  final String uid;

  // static accessors
  static BabyProfile? get currentProfile => _currentProfile;

  static set currentProfile(BabyProfile? profile) {
    if (profile == currentProfile) return;
    if (currentProfile != null) currentProfile!._removeDataSync();
    if (profile != null) profile._setDataSync();

    _currentProfile = profile;
  }

  // public accessors
  String get firstName => _firstName ?? '';
  String get lastName => _lastName ?? '';
  String get fullName => firstName + ' ' + lastName;

  DateTime? get birthDate => _birthDate;
  Duration? get age {
    if (birthDate != null) {
      return DateTime.now().difference(birthDate!);
    }
  }

  BabyProfile(this.uid);

  void _setDataSync() async {
    DataService.setProfileDataSync(uid, _setData);
  }

  void _removeDataSync() async {
    DataService.removeProfileDataSync(uid);
  }

  Future _setData(Map<String, dynamic> profileData) async {
    _firstName = profileData['firstName'] as String;
    _lastName = profileData['lastName'] as String;
    _birthDate = DateTime.parse(profileData['birthData'] as String);
  }
}
