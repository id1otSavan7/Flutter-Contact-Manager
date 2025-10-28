import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/Contact.dart';

class Book {
  //Reference for our Hive Box that is opened in main.dart
  final Box<Contact> _data = Hive.box<Contact>('Contacts');
  final Box<MyContact> _myData = Hive.box<MyContact>('MyContacts');

  List<Contact> contacts = [];

  //Function to add new contact in the hive.
  Future<void> addContact(Contact contact) async {
    await _data.add(contact);
    print('Data has been added');
  }

  //Function to update current contact data in the hive.
  Future<void> updateContact(int index, Contact newContact) async {
    if (_data.isNotEmpty){
      await _data.putAt(index, newContact);
      print('Data was updated');
    }
  }

  //Function to remove a certain indexed contact in the hive.
  Future<void> deleteContact(int index) async {
    if (_data.isNotEmpty){
      await _data.deleteAt(index);
      print('Datas has been removed');
    }
  }

  //Function on clearing all contact data in the hive.
  Future<void> clearContact() async {
    await _data.clear();
  }

  //Function to read contacts that is stored in the hive.
  List<Contact>? fetchContactData(int index) {
    if (_data.isNotEmpty){
      contacts = _data.values.toList();
      return contacts;
    }
    return null;
  }

  //Function to get personal data.
  MyContact? fetchPersonalData(){
    if(_myData.isNotEmpty){
      MyContact? myInfo = _myData.getAt(0);
      return myInfo;
    }
    return null;
  }

  //Function to add new contact in the hive.
  Future<void> addPersonalContact(MyContact contact) async {
    await _myData.add(contact);
  }

  //Function to update current contact data in the hive.
  Future<void> updatePersonalContact(MyContact newContact) async {
    if (_myData.isNotEmpty){
      await _myData.putAt(0, newContact);
      print('Data was updated');
    }
  }

  //Function to remove a certain indexed contact in the hive.
  Future<void> deletePersonalContact(int index) async {
    if (_myData.isNotEmpty){
      await _myData.deleteAt(index);
      print('Datas has been removed');
    }
  }
}