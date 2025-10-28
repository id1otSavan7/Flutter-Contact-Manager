import 'package:hive/hive.dart';
part 'Contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  String? recipientName;
  
  @HiveField(1)
  String? recipientPhoneNumber;

  @HiveField(2)
  String? recipientEmailAddress;

  @HiveField(3)
  String? recipientAddress;

  @HiveField(4)
  String? recipientRelation;

  Contact({
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.recipientEmailAddress,
    required this.recipientAddress,
    required this.recipientRelation,
  });
}

@HiveType(typeId: 1)
class MyContact extends HiveObject {
  @HiveField(0)
  String? myName;
  
  @HiveField(1)
  String? myFirstPhoneNumber;

  @HiveField(2)
  String? mySecondPhoneNumber;

  @HiveField(3)
  String? myEmailAddress;

  @HiveField(4)
  String? myHomeAddress;

  MyContact({
    required this.myName,
    required this.myFirstPhoneNumber,
    required this.mySecondPhoneNumber,
    required this.myEmailAddress,
    required this.myHomeAddress,
  });
}