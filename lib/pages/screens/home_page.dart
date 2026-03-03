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
          child: SingleChildScrollView(
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: defaultTextColor,
                          width: 2,
                        )
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text("My Profile", style: headerTextStyle,),
                    )
                  ),
                  const SizedBox(height: 10,),
                  PersonalContactTile(
                    name: myInfo?.myName,
                    activePhoneNumber: myInfo?.myFirstPhoneNumber,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: defaultTextColor,
                        width: 2,
                      )
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text("Contact List", style: headerTextStyle,),
                  )
                ),
                const SizedBox(height: 10,),
                ValueListenableBuilder(
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
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ContactTile(
                              contact: contact,
                              isBeingModified: false,
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
