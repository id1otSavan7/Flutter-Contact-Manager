import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalFieldEntry extends StatefulWidget {
  final bool isBeingModified;
  final TextEditingController name;
  final TextEditingController firstPhoneNumber;
  final TextEditingController secondPhoneNumber;
  final TextEditingController email;
  final TextEditingController address;

  const PersonalFieldEntry({
    super.key,
    required this.isBeingModified,
    required this.name,
    required this.firstPhoneNumber,
    required this.secondPhoneNumber,
    required this.email,
    required this.address,
    });

  @override
  State<PersonalFieldEntry> createState() => _PersonalFieldEntryState();
}

class _PersonalFieldEntryState extends State<PersonalFieldEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            //User's Name
            TextField(
              readOnly: widget.isBeingModified,
              controller: widget.name,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
                prefixIcon: Icon(Icons.person),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),
            
            //User's First Phone Number 
            TextField(
              readOnly: widget.isBeingModified,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              controller: widget.firstPhoneNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number'),
                prefixIcon: Icon(Icons.phone),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),
            
            //User's Second Phone Number 
            TextField(
              readOnly: widget.isBeingModified,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              controller: widget.secondPhoneNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number'),
                prefixIcon: Icon(Icons.phone),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),

            //User's eMail
            TextField(
              readOnly: widget.isBeingModified,
              keyboardType: TextInputType.emailAddress,
              controller: widget.email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email Address'),
                prefixIcon: Icon(Icons.mail),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),
            
            //User's Address
            TextField(
              readOnly: widget.isBeingModified,
              keyboardType: TextInputType.streetAddress,
              controller: widget.address,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Location'),
                prefixIcon: Icon(Icons.home),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),
          ],
    );
  }
}