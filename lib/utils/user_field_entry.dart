import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserEntryField extends StatefulWidget {
  final bool isBeingModified;
  final TextEditingController name;
  final TextEditingController phoneNumber;
  final TextEditingController email;
  final TextEditingController address;
  final TextEditingController relation;

  const UserEntryField({
    super.key,
    required this.isBeingModified,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.relation
    });

  @override
  State<UserEntryField> createState() => _UserEntryFieldState();
}

class _UserEntryFieldState extends State<UserEntryField> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            //Recipient's Name
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
            
            //Recipient's Phone Number
            TextField(
              readOnly: widget.isBeingModified,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              controller: widget.phoneNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone Number'),
                prefixIcon: Icon(Icons.phone),
                filled: true,
              ),
            ),
            const SizedBox(height: 10,),
            
            //Recipient's eMail
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
            
            //Recipient's Address
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
            
            //Recipient's Relationship
            TextField(
              readOnly: widget.isBeingModified,
              keyboardType: TextInputType.text,
              controller: widget.relation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Relationship'),
                prefixIcon: Icon(Icons.group),
                filled: true,
              ),
            ),
          ],
    );
  }
}