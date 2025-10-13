import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/pages/view_contact_page.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  final Contact? contact;
  final int index;
  final bool isBeingModified;

  const ContactTile({
    super.key,
    required this.contact,
    required this.index,
    required this.isBeingModified,
    });

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      color: defaultColor,
      child: ListTile(
        leading: const CircleAvatar(
          child: Center(
            child: Icon(Icons.person),
          ),
        ),
        title: Text(widget.contact!.recipientName ?? 'Unknown Recipient'),
        subtitle: Text(widget.contact!.recipientPhoneNumber ?? ''),
        onTap: () {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (BuildContext context) => ViewContactPage(
              index: widget.index, 
              isBeingModified: widget.isBeingModified, 
              recipientName: widget.contact!.recipientName, 
              recipientPhoneNumber: widget.contact!.recipientPhoneNumber, 
              recipientEmailAddress: widget.contact!.recipientEmailAddress, 
              recipientAddress: widget.contact!.recipientAddress, 
              recipientRelation: widget.contact!.recipientRelation
            )),
          );
          
        },
      ),
    );
  }
}