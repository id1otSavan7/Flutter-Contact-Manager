import 'package:flutter/material.dart';

Color defaultColor = Colors.white;
Color? defaultBodyColor = Colors.grey[100];
Color defaultTextColor = const Color.fromARGB(255, 75, 75, 75);
Color defaultIconColor = const Color.fromARGB(255, 60, 60, 60);
Color subtextColor = const Color.fromARGB(255, 100, 100, 100);
Color saveButtonColor = const Color.fromARGB(255, 125, 255, 125);
Color cancelButtonColor = const Color.fromARGB(255, 255, 125, 125);
Color defaultButtonColor = Colors.blueGrey;

TextEditingController recipientName = TextEditingController();
TextEditingController recipientPhoneNumber = TextEditingController();
TextEditingController recipientEmailAddress = TextEditingController();
TextEditingController recipientAddress = TextEditingController();
TextEditingController recipientRelation = TextEditingController();

TextEditingController myName = TextEditingController();
TextEditingController myFirstPhoneNumber = TextEditingController();
TextEditingController mySecondPhoneNumber = TextEditingController();
TextEditingController myEmailAddress = TextEditingController();
TextEditingController myHomeAddress = TextEditingController();

TextStyle addTextStyle = TextStyle(
  fontSize: 12,
  fontStyle: FontStyle.italic,
  color: defaultTextColor, 
  letterSpacing: 1.5,
);

TextStyle defaultTextStyle = TextStyle(
  fontSize: 14,
  letterSpacing: 1.2,
  color: defaultTextColor, 
);

TextStyle headerTextStyle = TextStyle(
  fontSize: 16,
  letterSpacing: 1.5,
  fontWeight: FontWeight.bold,
  color: defaultTextColor, 
);

TextStyle titleTextStyle = TextStyle(
  fontSize: 16,
  color: defaultTextColor, 
);

TextStyle subtitleTextStyle = TextStyle(
  fontSize: 12,
  color: subtextColor, 
);