import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/cards/contact_tile.dart';
import 'package:contact_manager/utils/widgets/emptylist_notice.dart';
import 'package:contact_manager/utils/cards/personal_contact_tile.dart';
import 'package:contact_manager/utils/widgets/quickCallSection.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  RecipientData record = RecipientData();
  PersonalData myRecord = PersonalData();
  QuickCallDataRecord quickCalls = QuickCallDataRecord();

  MyContact? myInfo;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool isEdittingQC = false;
  String searchQuery = '';
  int _selectedIndex = 1;

  final List<String> _routes = [
    '/addContact',
    '/home',
    '/viewProfile',
  ];

  void _navigateToPages(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.popAndPushNamed(context, _routes[_selectedIndex]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myInfo = myRecord.fetchPersonalData();
    /*
    bool ifItExists = phoneNumberExists('911');
    if(!ifItExists){
      record.addContact(Contact(
        recipientName: '**Emergency-Line**', 
        recipientPhoneNumber: '911', 
        recipientEmailAddress: 'No data recorded.', 
        recipientAddress: 'No data recorded.', 
        recipientRelation: 'No data recorded.'
      ));
    }

    record.addContact(Contact(
        recipientName: 'Lance Andrei Sombillo', 
        recipientPhoneNumber: '09936115161', 
        recipientEmailAddress: 'No data recorded.', 
        recipientAddress: 'No data recorded.', 
        recipientRelation: 'No data recorded.'
      ));

      record.addContact(Contact(
        recipientName: 'Julian Menendez', 
        recipientPhoneNumber: '09952167134', 
        recipientEmailAddress: 'No data recorded.', 
        recipientAddress: 'No data recorded.', 
        recipientRelation: 'No data recorded.'
      ));

      record.addContact(Contact(
        recipientName: 'Aaron Luis Dagul', 
        recipientPhoneNumber: '09996335112', 
        recipientEmailAddress: 'No data recorded.', 
        recipientAddress: 'No data recorded.', 
        recipientRelation: 'No data recorded.'
      ));
      */
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
            label: const Text('Search'),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBodyColor,
      appBar: AppBar(
        title: const Text('C O N T A C T S'),
        backgroundColor: defaultColor,
        actions: [
          //Searching
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  searchQuery = '';
                  searchController.clear();
                });
              },
              icon: (!isSearching)
                  ? const Icon(Icons.search)
                  : const Icon(Icons.close)),

          //Modify Settings
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateToPages,
          items: const [
            //Page Route: Home
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'ADD CONTACT'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'CONTACTS'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
          ]),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSearching) ...[
                buildSearchBar(context),
                const SizedBox(height: 10),
              ],
              if (!isSearching) ...[BuildQuickCallSection(quickCalls: quickCalls, record: record)],
              if (!isSearching && myRecord.isFilled) ...[
                const Text("My Profile"),
                PersonalContactTile(
                  name: myInfo?.myName,
                  activePhoneNumber: myInfo?.myFirstPhoneNumber,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
              const Text("Contact List"),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: record.listenables,
                    builder: (context, box, _) {
                      List<Contact> contacts =
                          box.values.toList().cast<Contact>();
                      contacts.sort((a, b) => a.recipientName!
                          .toLowerCase()
                          .compareTo(b.recipientName!.toLowerCase()));
                      if (contacts.isEmpty) {
                        return EmptyListNotice(
                          function: () {
                            Navigator.popAndPushNamed(context, '/addContact');
                          },
                        );
                      }
                      if (searchQuery.isNotEmpty) {
                        contacts = contacts.where((contact) {
                          final name =
                              contact.recipientName?.toLowerCase() ?? '';
                          final phoneNumber =
                              contact.recipientPhoneNumber ?? '';
                          final email =
                              contact.recipientEmailAddress?.toLowerCase() ??
                                  '';
                          return name.contains(searchQuery) ||
                              phoneNumber.contains(searchQuery) ||
                              email.contains(searchQuery);
                        }).toList();
                      }
                      return ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ContactTile(
                              contact: contact,
                              isBeingModified: false,
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
