import 'package:client/services/data_service.dart';

class BabyProfile {
  static BabyProfile? _currentProfile;

  // private properties
  bool? _created;
  String? _firstName;
  String? _lastName;
  int? _gender;
  double? _height;
  double? _weight;
  DateTime? _birthDate;
  Map<String, String>? _allergies;

  String? _pediatrician;
  String? _pediatricianPhone;

  String? _profilePic;

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
  String get gender {
    if (_gender == 0) {
      return "Male";
    } else if (_gender == 1) {
      return "Female";
    } else {
      return "Other";
    }
  }
  double get height => _height ?? 0;
  double get weight => _weight ?? 0;
  DateTime? get birthDate => _birthDate;
  Duration? get age {
    if (birthDate != null) {
      return DateTime.now().difference(birthDate!);
    }
  }
  //Map<String, String> get allergies => _allergies;

  String get pediatrician => _pediatrician ?? '';
  String get pediatricianPhone => _pediatricianPhone ?? '';

  String get profilePic => _profilePic ?? 'images/Osbaldo.jpg';

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