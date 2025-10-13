import 'package:flutter/material.dart';

class ContactProfile extends StatefulWidget {
  final String? name;

  const ContactProfile({
    super.key,
    required this.name,
    });

  @override
  State<ContactProfile> createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  
  String getContactInitials(String? name){
    List<String> initial = [];
    if(name == null || name == 'Unknown Recipient' || name.trim().isEmpty){
      return '?';
    } else {
      initial = name.trim().split(RegExp(r'\s+'));
      if (initial.length == 1){
        return initial[0][0].toUpperCase();
      } else {
        return (initial[0][0] + initial[1][0]).toUpperCase(); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: 
      (getContactInitials(widget.name) == '?') ? 
        const Icon(Icons.person) : 
          Text(getContactInitials(widget.name)),
    );
  }
}