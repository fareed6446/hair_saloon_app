// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StylistModelAdapter extends TypeAdapter<StylistModel> {
  @override
  final int typeId = 4;

  @override
  StylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StylistModel(
      id: fields[0] as String,
      name: fields[1] as String,
      specialties: (fields[2] as List).cast<String>(),
      rating: fields[3] as double?,
      isActive: fields[4] as bool,
      createdAt: fields[5] as DateTime,
      imageUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StylistModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.specialties)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
