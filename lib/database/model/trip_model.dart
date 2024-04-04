import 'package:hive/hive.dart';
part 'trip_model.g.dart';

@HiveType(typeId: 2)
class TripModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String? destination;
  @HiveField(2)
  final DateTime? startdate;
  @HiveField(3)
  final DateTime? enddate;
  @HiveField(4)
  final String? tripname;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final String? image;
  @HiveField(7)
  final String? actvityType;
  @HiveField(8)
  final String? title;
  @HiveField(9)
  final String? time;
  TripModel(
      {this.id,
      required this.destination,
      required this.startdate,
      required this.enddate,
      required this.tripname,
      required this.description,
      required this.image,
      this.actvityType,
      this.title,
      this.time});
}
