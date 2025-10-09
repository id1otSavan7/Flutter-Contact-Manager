import 'package:contact_manager/utils/appButton.dart';
import 'package:flutter/material.dart';

void testFunction(){
  print('Was Clicked!');
}

String? isDataNull(String? data, String fallback){
  return data!.trim().isEmpty ? fallback : data.trim();
}

void showEmptyFieldError(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('TextField Left Empty...'),
          content: const Text('It seems like the Recipient\'s Phone Number Field was left empty. Please fill it up with corresponding required data before saving.'),
          actions: [
            AppButton(onPressedEvent: (){
              Navigator.pop(context);
            }, content: const Text('R E T R Y'))
          ],
        );
      }
    );
}

