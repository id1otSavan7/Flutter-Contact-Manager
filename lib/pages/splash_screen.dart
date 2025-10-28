import 'package:contact_manager/data/models/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class ContactSplashScreen extends StatefulWidget {
  const ContactSplashScreen({super.key});

  @override
  State<ContactSplashScreen> createState() => _ContactSplashScreenState();
}

class _ContactSplashScreenState extends State<ContactSplashScreen> {
  final Box<MyContact> _myData = Hive.box<MyContact>('MyContacts');

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), (){
      if(_myData.isEmpty){
        Navigator.of(context).popAndPushNamed('/viewProfile');
      } else {
        Navigator.popAndPushNamed(context, '/home');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                child: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 25,),
            SizedBox(
              height: 20,
              width: 150,
              child: Center(
                child: Text("LACS Phonebook"))),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}