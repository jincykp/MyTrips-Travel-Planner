import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_trips/database/model/data_model.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
Future<void> addUserProfile(UserModel value) async {
  final userDataBox = await Hive.openBox<UserModel>('user_data');
  await userDataBox.add(value);
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
  print("added");
}

Future<void> getAllUSerProfile() async {
  final userDataBox = await Hive.openBox<UserModel>('user_data');
  userListNotifier.value.clear();
  userListNotifier.value.addAll(userDataBox.values);
  userListNotifier.notifyListeners();
}

Future<UserModel?> getDetails(
  String email,
) async {
  final userBox = await Hive.openBox<UserModel>('user_data');
  final userEntry = userBox.values.firstWhere(
    (entry) {
      if (entry.email == email) {
        return true;
      } else {
        return false;
      }
    },
    orElse: () => UserModel(
        email: 'email',
        password: 'password',
        name: 'name',
        homecity: 'homecity'),
  );
  return userEntry;
}

addUserImage(UserModel image) async {
  final userDataBox = await Hive.openBox<UserModel>('user_data');
  await userDataBox.add(image);
  print("image added");
}

Future<List<UserModel>> getUserImage() async {
  final userDataBox = await Hive.openBox<UserModel>('user_data');
  final List<UserModel> images = userDataBox.values.toList();
  return images;
}
