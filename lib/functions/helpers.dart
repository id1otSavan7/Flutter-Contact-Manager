import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/widgets/app_button.dart';
import 'package:contact_manager/utils/widgets/emptylist_notice.dart';
import 'package:contact_manager/utils/cards/recipient_card.dart';
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

String? getFirstName(String? name){
  List<String> initial = [];
  if(name!.trim().isEmpty) {
    return '?';
  } else {
    name = name.replaceAll(RegExp(r'[!@#\$%^&*()_+={}\[\]|\\:;"<>,.?/~`]'), ' ');
    initial = name.trim().split(RegExp(r'\s+'));
    return initial[0].toString();
  }
}

void addQuickCallData(BuildContext context, RecipientData record, QuickCallDataRecord dataRecord) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return (record.isNotEmpty)
              ? Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: const Text(
                          "Add someone...",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: ListView.builder(
                            itemCount: record.length,
                            itemBuilder: (context, index) {
                              final contacts = record.fetchContactData();
                              final data = contacts?[index];
                              return RecipientQcCard(data: data);
                            }),
                      ),
                    ),
                  ],
                )
              : EmptyListNotice(
                  function: () {
                    Navigator.popAndPushNamed(context, '/addContact');
                  },
                );
        });
  }
