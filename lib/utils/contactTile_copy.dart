import 'package:contact_manager/functions/crud.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/showContactInfo.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  final String? recipientName;
  final String? recipientPhoneNumber;
  final int index;
  final Function(int index, Map<dynamic, dynamic> modifiedData) updateRecipientInfo ;
  final VoidCallback? deleteContactData;

  const ContactTile({
    super.key,
    required this.recipientName,
    required this.recipientPhoneNumber,
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
        recipientName: contacts[widget.index]['name'], 
        recipientPhoneNumber: contacts[widget.index]['phoneNumber'], 
        recipientEmailAddress: contacts[widget.index]['eMail'], 
        recipientAddress: contacts[widget.index]['homeAddress'], 
        recipientRelation: contacts[widget.index]['relation'],
      ),
    );

    if (result == 'delete') {
      if(widget.deleteContactData != null){
        widget.deleteContactData!();
      }
      print('Deleting data...');
    } else if (result is Map<dynamic, dynamic>){
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
        title: Text(widget.recipientName ?? 'Unknown Recipient'),
        subtitle: Text(widget.recipientPhoneNumber ?? ''),
        onTap: () {
          showContactInfo();
          
          /*
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipientInfoPage(
                recipientName: contacts[widget.index]['name'] ?? 'Unknown Recipient',
                recipientPhoneNumber: contacts[widget.index]['phoneNumber'] ?? '',
                recipientEmailAddress: contacts[widget.index]['eMail'] ?? 'No Data Recorded',
                recipientAddress: contacts[widget.index]['homeAddress'] ?? 'No Data Recorded',
                recipientRelation: contacts[widget.index]['relation'] ?? 'No Data Recorded',
              ),
            ),
          );
          */
        },
      ),
    );
  }
}