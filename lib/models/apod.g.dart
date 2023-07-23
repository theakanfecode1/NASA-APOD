// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApodAdapter extends TypeAdapter<Apod> {
  @override
  final int typeId = 0;

  @override
  Apod read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Apod(
      title: fields[0] as String,
      date: fields[1] as String,
      m64: fields[2] as String,
      explanation: fields[3] as String,
      url: fields[4] as String,
      hdUrl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Apod obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.m64)
      ..writeByte(3)
      ..write(obj.explanation)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.hdUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
