import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/widgets/profile.dart';
import 'package:flutter/material.dart';

class RecipientQcCard extends StatefulWidget {
  final Contact? data;
  const RecipientQcCard({
    super.key,
    required this.data,
    });

  @override
  State<RecipientQcCard> createState() => _RecipientQcCard();
}

class _RecipientQcCard extends State<RecipientQcCard> {
  QuickCallDataRecord dataRecord = QuickCallDataRecord();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: defaultColor, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(widget.data!.recipientName ?? 'Unknown Recipient'),
        subtitle: Text(widget.data!.recipientPhoneNumber ?? ''),
        leading: ContactProfile(radius: 30, name: widget.data!.recipientName),
        onTap: () {
          final quickCallData = QuickCallList(
              contactName: widget.data!.recipientName,
              contactNumber: widget.data!.recipientPhoneNumber);
          setState(() {
            dataRecord.addDataToList(quickCallData);
          });
          Navigator.pop(context);
        },
      ),
    );
  }
}
