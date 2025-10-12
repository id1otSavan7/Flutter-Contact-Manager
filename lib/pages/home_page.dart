import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/contact_tile.dart';
import 'package:contact_manager/utils/emptylist_notice.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Box<Contact> _data = Hive.box<Contact>('Contacts');
  Book book = Book();

  int _selectedIndex = 1;
  final List<String> _routes = [
      '/addContact',
      '/home',
      '/viewProfile',
  ];

  void _navigateToPages(int index) {
    if(_selectedIndex != index){
      setState(() {
        _selectedIndex = index;
      });
      Navigator.popAndPushNamed(context, _routes[_selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: defaultBodyColor,
        appBar: AppBar(
          title: const Text('C O N T A C T S'),
          elevation: 0,
          backgroundColor: defaultColor,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:  _selectedIndex,
          onTap: _navigateToPages,
          items: const [
            //Page Route: Home
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'ADD CONTACT'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'CONTACTS'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'PROFILE'
            ),
          ]),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder(
            valueListenable: _data.listenable(), 
            builder: (context, box, _){
              final contacts = box.values.toList().cast<Contact>();
              if (contacts.isEmpty){
                return EmptyListNotice(
                  function: () {
                    Navigator.popAndPushNamed(
                      context, '/addContact');
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