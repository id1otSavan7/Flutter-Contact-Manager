import 'package:contact_manager/functions/func_barrel.dart';
import 'package:contact_manager/utils/contactTile_copy.dart';
import 'package:contact_manager/utils/listEmptyNotice.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
              Navigator.popAndPushNamed(context, '/addRecipient');
            }, icon: const Icon(Icons.add))
          ],
        ),
        body: Container(
          color: defaultBodyColor,
          padding: const EdgeInsets.all(10),
          child: (contacts.isEmpty) ? EmptyListNotice( 
            function: (){
              Navigator.popAndPushNamed(context, '/addRecipient');
            }) : ListView.builder(
              itemCount: contacts.length, 
              itemBuilder: (context, index) {
                return ContactTile(
                  recipientName: contacts[index]['name'], 
                  recipientPhoneNumber: contacts[index]['phoneNumber'],
                  index: index,
                  updateRecipientInfo: (index, modifiedData){
                    setState(() {
                      updateContact(index, modifiedData);
                    });
                  },
                  deleteContactData: (){
                    final contact = contacts[index];
                    setState(() {
                      removeContact(contact);
                    });
                  },

                );
              })
        ),
      ),
    );
  }
}