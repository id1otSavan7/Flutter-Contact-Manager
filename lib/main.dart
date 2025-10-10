import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/pages/addContactPage.dart';
import 'package:contact_manager/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize our Hive/Local Storage
  await Hive.initFlutter();

  Hive.registerAdapter(ContactAdapter());
  //Open the Hive Container
  await Hive.openBox<Contact>('Contacts');

  //Runs the execution of the Application
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      theme: ThemeData(useMaterial3: true),
      //Establish routes to navigate through several pages
      routes: {
        '/homePage':(context) => const Homepage(),
        '/addContactPage':(context) => const AddRecipientPage(),
      },
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Homepage();
  }
}