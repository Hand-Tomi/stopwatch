// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_stopwatch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentStopwatchAdapter extends TypeAdapter<CurrentStopwatch> {
  @override
  final int typeId = 4;

  @override
  CurrentStopwatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentStopwatch(
      start: fields[0] as int,
      stop: fields[1] as int?,
      historyKey: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentStopwatch obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.stop)
      ..writeByte(2)
      ..write(obj.historyKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentStopwatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
