// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 0;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      recipientName: fields[0] as String?,
      recipientPhoneNumber: fields[1] as String?,
      recipientEmailAddress: fields[2] as String?,
      recipientAddress: fields[3] as String?,
      recipientRelation: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.recipientName)
      ..writeByte(1)
      ..write(obj.recipientPhoneNumber)
      ..writeByte(2)
      ..write(obj.recipientEmailAddress)
      ..writeByte(3)
      ..write(obj.recipientAddress)
      ..writeByte(4)
      ..write(obj.recipientRelation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
