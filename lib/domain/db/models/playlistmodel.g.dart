// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class playlistmodelAdapter extends TypeAdapter<playlistmodel> {
  @override
  final int typeId = 1;

  @override
  playlistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return playlistmodel(
      playlistname: fields[0] as String,
      playlistarray: (fields[1] as List).cast<songsmodel>(),
    );
  }

  @override
  void write(BinaryWriter writer, playlistmodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistname)
      ..writeByte(1)
      ..write(obj.playlistarray);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is playlistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
