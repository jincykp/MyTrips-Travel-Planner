// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryModelAdapter extends TypeAdapter<MemoryModel> {
  @override
  final int typeId = 3;

  @override
  MemoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryModel(
      id: fields[0] as int?,
      MemoryImage: fields[1] as String?,
      MemoryTripName: fields[2] as String?,
      MemoryDate: fields[3] as String?,
      MemoryExperience: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MemoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.MemoryImage)
      ..writeByte(2)
      ..write(obj.MemoryTripName)
      ..writeByte(3)
      ..write(obj.MemoryDate)
      ..writeByte(4)
      ..write(obj.MemoryExperience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
