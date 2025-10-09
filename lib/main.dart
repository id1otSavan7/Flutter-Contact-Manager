import 'package:contact_manager/pages/addContactPage.dart';
import 'package:contact_manager/pages/homePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/homePage':(context) => const Homepage(),
        '/addRecipient':(context) => const AddRecipientPage(),
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