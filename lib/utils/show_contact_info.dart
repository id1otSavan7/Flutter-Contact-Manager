import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/barrel.dart';
import 'package:contact_manager/utils/app_button.dart';
import 'package:contact_manager/utils/user_field_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowContactInfo extends StatefulWidget {
  final String? recipientName;
  final String? recipientPhoneNumber;
  final String? recipientEmailAddress;
  final String? recipientAddress;
  final String? recipientRelation;

  const ShowContactInfo({
    super.key,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.recipientEmailAddress,
    required this.recipientAddress,
    required this.recipientRelation,
    });

  @override
  State<ShowContactInfo> createState() => _ShowContactInfoState();
}

class _ShowContactInfoState extends State<ShowContactInfo> {
  late TextEditingController _recipientName;
  late TextEditingController _recipientPhoneNumber;
  late TextEditingController _recipientEmailAddress;
  late TextEditingController _recipientAddress;
  late TextEditingController _recipientRelation;

  bool isBeingModified = false;

  @override
  void initState() {
    super.initState();
    _recipientName = TextEditingController(text: widget.recipientName);
    _recipientPhoneNumber = TextEditingController(text: widget.recipientPhoneNumber);
    _recipientEmailAddress = TextEditingController(text: widget.recipientEmailAddress);
    _recipientAddress = TextEditingController(text: widget.recipientAddress);
    _recipientRelation = TextEditingController(text: widget.recipientRelation);
  }

  @override
  void dispose() {
    _recipientName.dispose();
    _recipientPhoneNumber.dispose();
    _recipientEmailAddress.dispose();
    _recipientAddress.dispose();
    _recipientRelation.dispose();
    super.dispose();
  }

  void submitModifiedData() {
    if(_recipientPhoneNumber.text.isNotEmpty){
      final contact = Contact(
        recipientName: isDataNull(_recipientName.text, 'Unknown Recipient'), 
        recipientPhoneNumber: _recipientPhoneNumber.text, 
        recipientEmailAddress: isDataNull(_recipientEmailAddress.text, 'No data recorded'), 
        recipientAddress: isDataNull(_recipientAddress.text, 'No data recorded'), 
        recipientRelation: isDataNull(_recipientRelation.text, 'No data recorded')
      );
      Navigator.pop(context, contact);
    } else {
      var box = Hive.box<Contact>('Contacts');
            String title = '';
            String msg = '';
            bool ifItExists = box.values.any((contact) => contact.recipientPhoneNumber == recipientPhoneNumber.text);
            if(ifItExists){
              setState(() {
                title = 'THE PHONE NUMBER ALREADY EXISTS';
                msg = 'The Phone number you\'re trying to add, already exists in your book.';
              });
            } else {
              setState(() {
                title = 'AN IMPORTANT FIELD WAS LEFT EMPTY'; 
                msg = 'Are you trying to add a contact? A contact info atleast must have a Phone Number...';  
              }); 
            }
      showErrorDialog(context, title, msg);
    }
  }

  void deleteContactData(){
    Navigator.pop(context, 'delete');
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CONTACT INFO'),
              SizedBox(
                width: (isBeingModified) ? 150 :25 ,
                height: (isBeingModified) ? 35 : 0,
              ),
            ],
          ),
          children: [
            
      ],
    );
  }
}