import 'package:client/models/baby_profile.dart';
import 'package:client/models/todo.dart';
import 'package:client/services/data_service.dart';

import 'dart:async';

class AppUser {
  static AppUser? _currentUser;

  // private properties
  bool _isLoaded = false;
  List<String>? _profiles;
  List<String>? _sharedProfiles;
  Map<String, List<dynamic>>? _todoList;

  // public properties
  final String uid;

  //AppUser update stream
  static final _streamController = StreamController.broadcast();
  static final updateStream = _streamController.stream;

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
  Map<String, List<dynamic>> get toDoList => _todoList ?? {};

  //methods for todo
  List<Todo> get todosInProgress {
    List<Todo> tasks = [];
    _todoList?.forEach((key, value) {
      if (!value[4] && !value[5]) {
        tasks.add(
            Todo(
              title: value[0],
              description: value[1],
              id: value[2],
              createdTime: DateTime.parse(value[3]),
              isDone: value[4],
              removed: value[5],
            ));
      }
    });

    return tasks;
  }
  List<Todo> get todosCompleted {
    List<Todo> tasks = [];
    _todoList?.forEach((key, value) {
      if (value[4] && !value[5]) {
        tasks.add(
            Todo(
              title: value[0],
              description: value[1],
              id: value[2],
              createdTime: DateTime.parse(value[3]),
              isDone: value[4],
              removed: value[5],
            ));
      }
    });

    return tasks;
  }

  void updateTodo(Todo todo) {
    _todoList ??= {};
    _todoList![todo.id] = todo.fields();

    DataService.updateUserData(uid, {'to_do_list': _todoList?.map((key, value) => MapEntry(key, value))});
  } //creates empty map if null, else assigns fields of object
    //used to create new todos or edit them
  void removeTodo(Todo todo) {
    todo.removing();
    _todoList![todo.id] = todo.fields();

    DataService.updateUserData(uid, {'to_do_list': _todoList?.map((key, value) => MapEntry(key, value))});
  } //call removing method - changes removed value to true
  bool toggleTodoStatus(Todo todo) {
    todo.toggleDone();
    _todoList![todo.id] = todo.fields();

    DataService.updateUserData(uid, {'to_do_list': _todoList?.map((key, value) => MapEntry(key, value))});

    return todo.isDone;
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
    _todoList = (userData['to_do_list'] as Map).map((key, value) {
      return MapEntry(key, value as List);
    });
    if (ownedProfiles.isNotEmpty) {
      setCurrentProfile(ownedProfiles[0]);
    }

    _isLoaded = true;

    _streamController.add(currentUser);
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