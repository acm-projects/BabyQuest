import 'package:client/models/baby_profile.dart';
import 'package:client/models/todo.dart';
import 'package:client/services/data_service.dart';

class AppUser {
  static AppUser? _currentUser;

  // private properties
  bool _isLoaded = false;
  List<String>? _profiles;
  List<String>? _sharedProfiles;
  List<Todo>? _todoList;

  // public properties
  final String uid;

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
  List<Todo> get toDoList => _todoList ?? [];

  //methods for todo
  List<Todo> get todos => _todoList!.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted => _todoList!.where((todo) => todo.isDone == true).toList();
  void addTodo(Todo todo) {
    _todoList!.add(todo);
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
    _todoList =
        (userData['to_do_list'] as List).map((item) => item as Todo).toList();

    if (ownedProfiles.isNotEmpty) {
      setCurrentProfile(ownedProfiles[0]);
    }

    _isLoaded = true;
  }

  // Switches the currently displayed BabyProfile based on the provided uid
  void setCurrentProfile(String uid) {
    if (this != _currentUser) return;

    BabyProfile.currentProfile = BabyProfile(uid);
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