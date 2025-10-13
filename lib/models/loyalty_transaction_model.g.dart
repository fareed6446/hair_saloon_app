// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoyaltyTransactionModelAdapter
    extends TypeAdapter<LoyaltyTransactionModel> {
  @override
  final int typeId = 6;

  @override
  LoyaltyTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoyaltyTransactionModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      type: fields[2] as String,
      points: fields[3] as int,
      reference: fields[4] as String?,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LoyaltyTransactionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.points)
      ..writeByte(4)
      ..write(obj.reference)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
