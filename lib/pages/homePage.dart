import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/func_barrel.dart';
import 'package:contact_manager/utils/contactTile_copy.dart';
import 'package:contact_manager/utils/listEmptyNotice.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Box<Contact> _data = Hive.box<Contact>('Contacts');

  Book book = Book();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('C O N T A C T S'),
          elevation: 0,
          backgroundColor: defaultColor,
          actions: [
            IconButton(onPressed: (){
              Navigator.popAndPushNamed(context, '/addContactPage');
            }, icon: const Icon(Icons.add))
          ],
        ),
        body: Container(
          color: defaultBodyColor,
          padding: const EdgeInsets.all(10),
          child: ValueListenableBuilder(
            valueListenable: _data.listenable(), 
            builder: (context, box, _){
              final contacts = box.values.toList().cast<Contact>();
              if (contacts.isEmpty){
                return EmptyListNotice(
                  function: () {
                    Navigator.popAndPushNamed(
                      context, '/addContactPage');
                  },);
              }
              return ListView.builder(
              itemCount: contacts.length, 
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactTile(
                  contact: Contact(
                    recipientName: contact.recipientName, 
                    recipientPhoneNumber: contact.recipientPhoneNumber, 
                    recipientEmailAddress: contact.recipientEmailAddress, 
                    recipientAddress: contact.recipientAddress, 
                    recipientRelation: contact.recipientRelation
                  ),
                  index: index,
                  updateRecipientInfo: (index, modifiedData){
                    setState(() {
                      Book().updateContact(index, modifiedData);
                    });
                  },
                  deleteContactData: (){
                    setState(() {
                      Book().deleteContact(index);
                    });
                    
                  },
                );
              });
            })
        ),
      ),
    );
  }
}