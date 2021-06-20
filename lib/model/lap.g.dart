// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LapAdapter extends TypeAdapter<Lap> {
  @override
  final int typeId = 2;

  @override
  Lap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lap(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Lap obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lap)
      ..writeByte(1)
      ..write(obj.lapTime)
      ..writeByte(2)
      ..write(obj.splitTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
