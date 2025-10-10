import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/func_barrel.dart';
import 'package:contact_manager/utils/appButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      showEmptyFieldError(context);
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
              if (!isBeingModified) ...[
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircularAppButton(onPressedEvent: (){
                    setState(() {
                      isBeingModified = !isBeingModified;
                    });
                  }, content: const Icon(Icons.edit)),
                  CircularAppButton(onPressedEvent: (){
                    Navigator.pop(context, 'delete');
                  }, content: const Icon(Icons.delete))
                ],
                )
              ]

            ],
          ),
          children: [
            Container(
              color: defaultColor,
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Center(
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //Recipient's Name
                  TextField(
                    controller: _recipientName,
                    enabled: isBeingModified,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Recipient\'s Name'),
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  
                  //Recipient's Phone Number
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(15),
                    ],
                    controller: _recipientPhoneNumber,
                    enabled: isBeingModified,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Recipient\'s Phonenumber'),
                      prefixIcon: Icon(Icons.phone),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  
                  //Recipient's eMail
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _recipientEmailAddress,
                    enabled: isBeingModified,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Recipient\'s eMail'),
                      prefixIcon: Icon(Icons.mail),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  
                  //Recipient's Address
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: _recipientAddress,
                    enabled: isBeingModified,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Recipient\'s Home Address'),
                      prefixIcon: Icon(Icons.home),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  
                  //Recipient's Relationship
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _recipientRelation,
                    enabled: isBeingModified,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Recipient\'s Relationship'),
                      prefixIcon: Icon(Icons.group),
                      filled: true,
                ),
              ),
              
              SizedBox(height: (isBeingModified) ? 100 : 50,),
              
              (!isBeingModified) ?
              Center(
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: CircularAppButton(
                    onPressedEvent: (){}, 
                    content: const Icon(Icons.phone)),
                ),
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(onPressedEvent: (){
                    setState(() {
                      isBeingModified = false;
                    });
                  }, content: const Text('CANCEL')),
                  AppButton(onPressedEvent: (){
                    submitModifiedData();
                  }, content: const Text('SAVE')),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}