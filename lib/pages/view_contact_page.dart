import 'package:flutter/material.dart';

class ViewContactPage extends StatefulWidget {
  const ViewContactPage({super.key});

  @override
  State<ViewContactPage> createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('C O N T A C T   I N F O '),
          leading: IconButton(onPressed: (){
            Navigator.popAndPushNamed(context, '/home');
          }, icon: const Icon(Icons.arrow_back_ios_new)),
          actions: const [
            Row(
              children: [],
            )
          ],
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}