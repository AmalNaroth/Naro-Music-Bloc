// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songsmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class songsmodelAdapter extends TypeAdapter<songsmodel> {
  @override
  final int typeId = 0;

  @override
  songsmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return songsmodel(
      songName: fields[0] as String,
      artistName: fields[1] as String,
      uri: fields[2] as String,
      id: fields[3] as int,
      duration: fields[4] as int,
      count: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, songsmodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songName)
      ..writeByte(1)
      ..write(obj.artistName)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is songsmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
