import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/barrel.dart';
import 'package:contact_manager/utils/app_button.dart';
import 'package:contact_manager/utils/personal_field_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({
    super.key,});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final Box<MyContact> myData = Hive.box<MyContact>('MyContacts');
  bool isBeingModified = true;

  
  @override
  void initState() {
    super.initState();
    if(myData.isEmpty) setState(() => isBeingModified = false); 
    MyContact? data = Book().fetchPersonalData();
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
        title: (myData.isEmpty) ? const Text('S E T   P R O F I L E '): const Text('P R O F I L E'),
        leading: IconButton(onPressed: (){
          Navigator.popAndPushNamed(context, '/home');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          if (isBeingModified) ...[
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
                  isBeingModified: isBeingModified, 
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
        if(!isBeingModified) ...[
          AppButton(onPressedEvent: (){
            Navigator.popAndPushNamed(context, '/home');
          }, content: const Text("C A N C E L ")),
          AppButton(onPressedEvent: (){
            setState(() {
              final info = MyContact(
                myName: isDataNull(myName.text, 'Unknown Recipient'), 
                myFirstPhoneNumber: isDataNull(myFirstPhoneNumber.text, 'No Data Recorded'), 
                mySecondPhoneNumber: isDataNull(mySecondPhoneNumber.text, 'No Data Recorded'), 
                myEmailAddress: isDataNull(myEmailAddress.text, 'No Data recorded.'), 
                myHomeAddress: isDataNull(myHomeAddress.text, 'No Data recorded.')
              );
              if(myData.isEmpty){
                Book().addPersonalContact(info);
              } else {
                Book().updatePersonalContact(info);
              }
            });
            Navigator.popAndPushNamed(context, '/home');
          }, content: const Text("S A V E ")),
        ]
      ],
    );
  }
}