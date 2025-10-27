import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/helpers.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/app_button.dart';
import 'package:contact_manager/utils/user_field_entry.dart';
import 'package:flutter/material.dart';

class AddRecipientPage extends StatefulWidget {
  const AddRecipientPage({super.key});

  @override
  State<AddRecipientPage> createState() => _AddRecipientPageState();
}

class _AddRecipientPageState extends State<AddRecipientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBodyColor,
      appBar: AppBar(
        title: const Text('A D D   I N F O'),
        backgroundColor: defaultColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 380,
          width:  380*2,
          margin: const EdgeInsets.fromLTRB(25, 50, 25, 50),
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 15,
                blurRadius: 15,
                offset: Offset(0, 15)
              )
            ],
          ),
          child: UserEntryField(
            isBeingModified: false,
            name: recipientName, 
            phoneNumber: recipientPhoneNumber, 
            email: recipientEmailAddress, 
            address: recipientAddress, 
            relation: recipientRelation)
        ),
      ),
      persistentFooterButtons: [
        AppButton(onPressedEvent: (){
          disposeControllerData();
          Navigator.popAndPushNamed(context, '/home');
        }, content: const Text('CANCEL')),
        AppButton(onPressedEvent: (){
          bool itExists = phoneNumberExists(recipientPhoneNumber.text);
    
          if (recipientPhoneNumber.text.isEmpty){
            showErrorDialog(
              context, 
              'AN IMPORTANT FIELD WAS LEFT EMPTY', 
              'Are you trying to add a contact? A contact info atleast must have a Phone Number...'
            );
          } else if (itExists) { 
            showErrorDialog(
              context, 
              'PHONE NUMBER ALREADY EXISTS', 
              'The Phone Number you\'re trying to add already exists...'
            );
          } else {
            final contact = Contact(
              recipientName: isDataNull(recipientName.text, 'Unknown Recipient'), 
              recipientPhoneNumber: recipientPhoneNumber.text, 
              recipientEmailAddress: isDataNull(recipientEmailAddress.text, 'No data recorded.'), 
              recipientAddress: isDataNull(recipientAddress.text, 'No data recorded.'), 
              recipientRelation: isDataNull(recipientRelation.text, 'No data recorded.'),);
            setState(() {
              Book().addContact(contact);  
            });
            Navigator.popAndPushNamed(context, '/home');  
            disposeControllerData();
          }       
        }, content: const Text('SAVE')),
      ],
    );
  }
}