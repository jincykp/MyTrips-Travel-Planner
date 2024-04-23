import 'package:hive/hive.dart';
part 'memories_model.g.dart';

@HiveType(typeId: 3)
class MemoryModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  List<String>? MemoryImage;
  @HiveField(2)
  final String? MemoryTripName;
  @HiveField(3)
  final String? MemoryDate;
  @HiveField(4)
  final String? MemoryExperience;
  MemoryModel(
      {this.id,
      this.MemoryImage,
      this.MemoryTripName,
      this.MemoryDate,
      this.MemoryExperience});
}
