import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/widgets/profile.dart';
import 'package:flutter/material.dart';

class PersonalContactTile extends StatefulWidget {
  final String? name;
  final String? activePhoneNumber;
  

  const PersonalContactTile({
    required this.name,
    required this.activePhoneNumber,
    super.key});

  @override
  State<PersonalContactTile> createState() => _PersonalContactTileState();
}

class _PersonalContactTileState extends State<PersonalContactTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      color: defaultColor,
      child: ListTile(
        leading: ContactProfile(name: widget.name, radius: 20,),
        title: Text(widget.name ?? 'Unknown Recipient', style: titleTextStyle),
        subtitle: Text(widget.activePhoneNumber ?? '', style: subtitleTextStyle),
        onTap: () {
          Navigator.of(context).popAndPushNamed('/viewProfile');
        },
      ),
    );
  }
}