import 'package:flutter/material.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P R O F I L E '),
        leading: IconButton(onPressed: (){
          Navigator.popAndPushNamed(context, '/home');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: const [],
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}