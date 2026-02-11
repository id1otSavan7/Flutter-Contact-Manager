import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/barrel.dart';
import 'package:contact_manager/utils/widgets/app_button.dart';
import 'package:contact_manager/utils/widgets/field_entry/personal_field_entry.dart';
import 'package:flutter/material.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({
    super.key,});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  PersonalData myRecord = PersonalData();

  bool isBeingModified = true;

  
  @override
  void initState() {
    super.initState();
    if(myRecord.isFilled){
      isBeingModified = false;
      print("Personal Contact Already Exists!");
    } else {
      isBeingModified = true;
      print("Personal Contact Not Found!");
    }
    MyContact? data = myRecord.fetchPersonalData();
    myName = TextEditingController(text: data?.myName ?? '');
    myFirstPhoneNumber = TextEditingController(text: data?.myFirstPhoneNumber ?? '');
    mySecondPhoneNumber = TextEditingController(text: data?.mySecondPhoneNumber ?? '');
    myEmailAddress = TextEditingController(text: data?.myEmailAddress ?? '');
    myHomeAddress = TextEditingController(text: data?.myHomeAddress ?? '');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (myRecord.isFilled) ? const Text('S E T   P R O F I L E '): const Text('P R O F I L E'),
        leading: IconButton(onPressed: (){
          Navigator.popAndPushNamed(context, '/home');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          if (!isBeingModified) ...[
            AppIconButton(onPressedEvent: (){
              setState(() {
                isBeingModified = !isBeingModified;
              });
            }, content: const Icon(Icons.edit)),
          ]
        ],
        backgroundColor: defaultColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                PersonalFieldEntry(
                  isBeingModified: !isBeingModified, 
                  name: myName, 
                  firstPhoneNumber: myFirstPhoneNumber, 
                  secondPhoneNumber: mySecondPhoneNumber, 
                  email: myEmailAddress, 
                  address: myHomeAddress
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        if(isBeingModified) ...[
          AppButton(
            buttonColor: cancelButtonColor,
            onPressedEvent: (){
            Navigator.popAndPushNamed(context, '/home');
          }, content: const Text("C A N C E L ")),
          AppButton(
            buttonColor: saveButtonColor,
            onPressedEvent: (){
            setState(() {
              final info = MyContact(
                myName: isDataNull(myName.text, 'Unknown Recipient'), 
                myFirstPhoneNumber: isDataNull(myFirstPhoneNumber.text, 'No Data Recorded'), 
                mySecondPhoneNumber: isDataNull(mySecondPhoneNumber.text, 'No Data Recorded'), 
                myEmailAddress: isDataNull(myEmailAddress.text, 'No Data recorded.'), 
                myHomeAddress: isDataNull(myHomeAddress.text, 'No Data recorded.')
              );
              if(!myRecord.isFilled){
                myRecord.addPersonalContact(info);
                isBeingModified = false;
                print("Personal Contact Added!");
              } else {
                myRecord.updatePersonalContact(info);
                isBeingModified = false;
                print("Personal Contact Updated!");
              }
            });
            Navigator.popAndPushNamed(context, '/home');
          }, content: const Text("S A V E ")),
        ]
      ],
    );
  }
}