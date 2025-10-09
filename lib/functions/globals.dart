import 'package:flutter/material.dart';

Color defaultColor = Colors.white;
Color? defaultBodyColor = Colors.grey[100];

bool confWasClicked = false;
bool isModifying = false;

TextEditingController recipientName = TextEditingController();
TextEditingController recipientPhoneNumber = TextEditingController();
TextEditingController recipientEmailAddress = TextEditingController();
TextEditingController recipientAddress = TextEditingController();
TextEditingController recipientRelation = TextEditingController();