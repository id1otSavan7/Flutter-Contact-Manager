import 'package:contact_manager/functions/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController querry; 
  const SearchBar({
    required this.querry,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: defaultColor
      ),
      child: TextField(
        controller: querry,
        decoration: InputDecoration(
          label: const Text('Search'),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
        ),
        
      ),
    );
  }
}