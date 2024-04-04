// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelAdapter extends TypeAdapter<TripModel> {
  @override
  final int typeId = 2;

  @override
  TripModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModel(
      id: fields[0] as int?,
      destination: fields[1] as String?,
      startdate: fields[2] as DateTime?,
      enddate: fields[3] as DateTime?,
      tripname: fields[4] as String?,
      description: fields[5] as String?,
      image: fields[6] as String?,
      actvityType: fields[7] as String?,
      title: fields[8] as String?,
      time: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TripModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.destination)
      ..writeByte(2)
      ..write(obj.startdate)
      ..writeByte(3)
      ..write(obj.enddate)
      ..writeByte(4)
      ..write(obj.tripname)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.actvityType)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
