import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/helpers.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/appButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddRecipientPage extends StatefulWidget {
  const AddRecipientPage({super.key});

  @override
  State<AddRecipientPage> createState() => _AddRecipientPageState();
}

class _AddRecipientPageState extends State<AddRecipientPage> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: defaultBodyColor,
      appBar: AppBar(
        title: (isModifying) ? const Text('M O D I F Y I N G   I N F O ') : const Text('A D D   I N F O'),
        backgroundColor: defaultColor,
      ),
      body: Container(
        height: 350,
        margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 0)
            )
          ],
        ),
        child: Column(
          children: [
            //Recipient's Name
            TextField(
              controller: recipientName,
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
              controller: recipientPhoneNumber,
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
              controller: recipientEmailAddress,
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
              controller: recipientAddress,
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
              controller: recipientRelation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Recipient\'s Relationship'),
                prefixIcon: Icon(Icons.group),
                filled: true,
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        AppButton(onPressedEvent: (){
          Navigator.popAndPushNamed(context, '/homePage');
        }, content: const Text('CANCEL')),
        AppButton(onPressedEvent: (){
          if (recipientPhoneNumber.text.isNotEmpty){
            final contact = Contact(
              recipientName: recipientName.text, 
              recipientPhoneNumber: recipientPhoneNumber.text, 
              recipientEmailAddress: recipientEmailAddress.text, 
              recipientAddress: recipientAddress.text, 
              recipientRelation: recipientRelation.text);
            
            setState(() {
              Book().addContact(contact);  
            });
            
            Navigator.popAndPushNamed(context, '/homePage');
          } else {
            showEmptyFieldError(context);
          }
          
        }, content: const Text('SAVE')),
      ],
    ));
  }
}