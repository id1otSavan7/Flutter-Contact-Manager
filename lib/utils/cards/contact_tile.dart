import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/pages/screens/sub_screens/view_contact_page.dart';
import 'package:contact_manager/utils/widgets/profile.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  final Contact contact;
  final bool isBeingModified;

  const ContactTile({
    super.key,
    required this.contact,
    required this.isBeingModified,
    });

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      color: defaultColor,
      shadowColor: Colors.grey[300],
      child: ListTile(
        leading: ContactProfile(name: widget.contact.recipientName, radius: 20,),
        title: Text(widget.contact.recipientName ?? 'Unknown Recipient', style: titleTextStyle),
        subtitle: Text(widget.contact.recipientPhoneNumber ?? '', style: subtitleTextStyle),
        onTap: () {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (BuildContext context) => ViewContactPage(
              contact: widget.contact, 
              isBeingModified: widget.isBeingModified, 
            )),
          );
          
        },
      ),
    );
  }
}