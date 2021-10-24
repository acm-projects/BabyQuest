import 'package:client/services/data_service.dart';

class BabyProfile {
  static BabyProfile? _currentProfile;

  // private properties
  String? _firstName;
  String? _lastName;
  DateTime? _birthDate;
  int? _gender;
  double? _height;
  double? _weight;

  String? _pediatrician;
  String? _pediatricianPhone;
  String? _profilePic;
    
  Map<String, int>? _allergies;
  Map<String, int>? _diaperChanges;
  List<Map<DateTime, DateTime>>? _sleep;
  Map<String, int>? _feedings;

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

  // private methods
  void _setDataSync() async {
    DataService.setProfileDataSync(uid, _setData);
  }

  void _removeDataSync() async {
    DataService.removeProfileDataSync(uid);
  }

  Future _setData(Map<String, dynamic> profileData) async {
    _firstName = profileData['first_name'] as String;
    _lastName = profileData['last_name'] as String;
    _birthDate = DateTime.parse(profileData['birth_date'] as String);
  }
}