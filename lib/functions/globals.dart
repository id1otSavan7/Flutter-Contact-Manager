import 'package:flutter/material.dart';

Color defaultColor = Colors.white;
Color? defaultBodyColor = Colors.grey[100];

TextEditingController recipientName = TextEditingController();
TextEditingController recipientPhoneNumber = TextEditingController();
TextEditingController recipientEmailAddress = TextEditingController();
TextEditingController recipientAddress = TextEditingController();
TextEditingController recipientRelation = TextEditingController();

final int _selectedIndex = 0;

final List<String> _routes = [
    '/home',
    '/addContact',
    '/viewContact',
    '/viewProfile',
    '/settings',
];