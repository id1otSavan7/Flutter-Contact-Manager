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

class MyContactAdapter extends TypeAdapter<MyContact> {
  @override
  final int typeId = 1;

  @override
  MyContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyContact(
      myName: fields[0] as String?,
      myFirstPhoneNumber: fields[1] as String?,
      mySecondPhoneNumber: fields[2] as String?,
      myEmailAddress: fields[3] as String?,
      myHomeAddress: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyContact obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.myName)
      ..writeByte(1)
      ..write(obj.myFirstPhoneNumber)
      ..writeByte(2)
      ..write(obj.mySecondPhoneNumber)
      ..writeByte(3)
      ..write(obj.myEmailAddress)
      ..writeByte(4)
      ..write(obj.myHomeAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
