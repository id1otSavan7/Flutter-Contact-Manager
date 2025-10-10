import 'package:contact_manager/functions/globals.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/Contact.dart';

class Book {
  //Reference for our Hive Box that is opened in main.dart
  final Box<Contact> _data = Hive.box<Contact>('Contacts');

  //Function to add new contact in the hive.
  Future<void> addContact(Contact contact) async {
    await _data.add(contact);
    print('Data has been added');

    recipientName.clear();
    recipientPhoneNumber.clear();
    recipientEmailAddress.clear();
    recipientAddress.clear();
    recipientRelation.clear();
  }

  Future<void> updateContact(int index, Contact newContact) async {
    if (_data.isNotEmpty){
      await _data.putAt(index, newContact);
      print('Data was updated');
    }
  }

  Future<void> deleteContact(int index) async {
    if (_data.isNotEmpty){
      await _data.deleteAt(index);
      print('Datas has been removed');
    }
  }

  Future<void> clearContact() async {
    await _data.clear();
  }

  //Function to read contacts that is stored in the hive.
  Contact? fetchContactData(int index) {
    if (_data.isNotEmpty){
      return _data.getAt(index);
    }
    return null;
  }
}