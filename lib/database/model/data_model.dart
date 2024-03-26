import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String name;
  @HiveField(3)
  String? image;
  @HiveField(4)
  final String homecity;
  UserModel(
      {required this.email,
      required this.password,
      required this.name,
      this.image,
      required this.homecity});
}
