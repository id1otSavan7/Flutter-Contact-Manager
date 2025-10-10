import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/showContactInfo.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  final Contact? contact;
  final int index;
  final Function(int index, Contact modifiedData) updateRecipientInfo ;
  final VoidCallback? deleteContactData;

  const ContactTile({
    super.key,
    required this.contact,
    required this.index,
    required this.updateRecipientInfo,
    required this.deleteContactData,
    });

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {

  Future<void> showContactInfo() async {
    final result = await showDialog(
      context: context, 
      builder: (context) => ShowContactInfo(
        recipientName: widget.contact!.recipientName, 
        recipientPhoneNumber: widget.contact!.recipientPhoneNumber, 
        recipientEmailAddress: widget.contact!.recipientEmailAddress, 
        recipientAddress: widget.contact!.recipientAddress, 
        recipientRelation: widget.contact!.recipientRelation,
      ),
    );

    if (result == 'delete') {
      if(widget.deleteContactData != null){
        widget.deleteContactData!();
      }
      print('Deleting data...');
    } else if (result is Contact){
        widget.updateRecipientInfo(widget.index, result);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
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
          showContactInfo();
        },
      ),
    );
  }
}