import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void testFunction(){
  print('Was Clicked!');
}

String? isDataNull(String? data, String fallback){
  return data!.trim().isEmpty ? fallback : data.trim();
}

void showErrorDialog(BuildContext context, String? title, String? msg){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title!),
          content: Text(msg!),
          actions: [
            AppButton(onPressedEvent: (){
              Navigator.pop(context);
            }, content: const Text('R E T R Y'))
          ],
        );
      }
    );
}

bool phoneNumberExists(String phoneNumber) {
  var box = Hive.box<Contact>('Contacts');
  phoneNumber = phoneNumber.trim();
  return box.values.any((contacts) => contacts.recipientPhoneNumber == phoneNumber);
}

void disposeControllerData() {
  recipientName.clear();
  recipientPhoneNumber.clear();
  recipientEmailAddress.clear();
  recipientAddress.clear();
  recipientRelation.clear();
}

