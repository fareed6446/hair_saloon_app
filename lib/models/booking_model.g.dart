// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModelAdapter extends TypeAdapter<BookingModel> {
  @override
  final int typeId = 3;

  @override
  BookingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      serviceId: fields[2] as String,
      packageId: fields[3] as String?,
      stylistId: fields[4] as String?,
      dateTime: fields[5] as DateTime,
      status: fields[6] as String,
      loyaltyPointsAwarded: fields[7] as int,
      notes: fields[8] as String?,
      createdAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.serviceId)
      ..writeByte(3)
      ..write(obj.packageId)
      ..writeByte(4)
      ..write(obj.stylistId)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.loyaltyPointsAwarded)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
