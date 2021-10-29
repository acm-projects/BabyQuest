import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:client/services/data_service.dart';

class BabyProfile {
  static BabyProfile defaultProfile = BabyProfile('');
  static BabyProfile? _currentProfile;

  // private properties
  String? _name;
  int? _gender;
  double? _height;
  double? _weightLb;
  double? _weightOz;
  DateTime? _birthDate;
  Map<String, int>? _allergies;

  String? _pediatrician;
  String? _pediatricianPhone;
  String? _formattedPedPhone;

  String? _profilePic;

  Map<String, int>? _diaperChanges;
  List<Map<DateTime, DateTime>>? _sleep;
  Map<String, int>? _feedings;

  // public properties
  final String uid;

  // static accessors
  static BabyProfile get currentProfile => _currentProfile ?? defaultProfile;

  static set currentProfile(BabyProfile? profile) {
    if (profile == currentProfile) return;
    if (currentProfile.exists) currentProfile._removeDataSync();
    if (profile != null) profile._setDataSync();

    _currentProfile = profile;
  }

  // public accessors
  bool get exists => uid.isNotEmpty;

  String get name => _name ?? '';

  int get genderRaw => _gender ?? 0;
  String get gender {
    switch (_gender) {
      case 0:
        return "Male";
      case 1:
        return "Female";
      default:
        return "Other";
    }
  }

  IconData get genderIcon {
    switch (_gender) {
      case 0:
        return Icons.male;
      case 1:
        return Icons.female;
      default:
        return Icons.transgender;
    }
  }

  double get heightIn => _height ?? 0;
  String get height {
    return heightIn.toString() + '"';
  }

  double get weightLb => _weightLb ?? 0;
  double get weightOz => _weightOz ?? 0;
  String get weight {
    return weightLb.toInt().toString() + 'lbs ' + weightOz.toString() + 'oz';
  }

  DateTime? get birthDate => _birthDate;
  String get age {
    if (birthDate == null) return '';
    int days = DateTime.now().difference(birthDate!).inDays;

    if (days < 7) {
      return days.toString() + ' days';
    } else if (days < 30.44) {
      return (days / 7).round().toString() + ' weeks';
    } else if (days < 365.25) {
      return (days / 30.44).round().toString() + ' months';
    } else {
      return (days / 365.25).round().toString() + ' years';
    }
  } //will calcuate age in days, weeks, months, or years and return as String

  Map<String, int> get allergies => _allergies ?? {};

  String get pediatrician => _pediatrician ?? '';
  String get pediatricianPhone => _pediatricianPhone ?? '';
  String get formattedPedPhone {
    return _formattedPedPhone ?? '';
  }

  String get profilePic => _profilePic ?? '';

  BabyProfile(this.uid);

  // private methods
  void _setDataSync() async {
    DataService.setProfileDataSync(uid, _setData);
  }

  void _removeDataSync() async {
    DataService.removeProfileDataSync(uid);
  }

  Future _setData(Map<String, dynamic> profileData) async {
    _name = profileData['name'] as String;
    _gender = profileData['gender'] as int;
    _height = profileData['height'] as double;
    _weightLb = profileData['weightLb'] as double;
    _weightOz = profileData['weightOz'] as double;
    _birthDate = DateTime.parse(profileData['birth_date'] as String);
    _allergies = (profileData['allergies'] as Map<String, dynamic>)
        .map((String key, dynamic value) {
      return MapEntry(key, value as int);
    });

    _pediatrician = profileData['pediatrician'];
    _pediatricianPhone = profileData['pediatrician_phone'];
   _formattedPedPhone = (await FlutterLibphonenumber().format(pediatricianPhone, 'US'))['formatted'];

    _profilePic = profileData['profile_pic'] as String;

    // _diaperChanges = profileData['diaper_changes'];
    // _sleep = profileData['sleep'];
    // _feedings = profileData['feedings'];
  }

  void updateData(Map<String, dynamic> data) {
    DataService.updateProfileData(uid, data);
  }
}
