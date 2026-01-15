import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/Contact.dart';

class RecipientData {
  //final QuickCallDataRecord _qcList = QuickCallDataRecord();
  final Box<Contact> _data = Hive.box<Contact>('Contacts');
  
  //Instance getter for data...
  int get length => _data.length;
  ValueListenable<Box> get listenables => _data.listenable(); 
  bool get isNotEmpty => _data.isNotEmpty;

  //Function to add new contact in the hive.
  Future<void> addContact(Contact contact) async {
    await _data.add(contact);
    print('Data has been added');
  }

  //Function to update current contact data in the hive.
  Future<void> updateContact(int index, Contact newContact) async {
    if (_data.isNotEmpty) {
      await _data.putAt(index, newContact);
      print('$index Data was updated');
    }
  }

  //Function to remove a certain indexed contact in the hive.
  Future<void> deleteContact(int index) async {
    if (_data.isNotEmpty) {
      /*
      final list = _qcList.fetchData();

      for (final qcData in list){
        final data = _data.values.firstWhere(
          (c) => c.recipientPhoneNumber == qcData.contactNumber, 
        );
      }
      */
      final contacts = fetchContactData();
      final dataToDelete = contacts![index];
      final key = dataToDelete.key;
      await _data.delete(key);
    }
  }

  //Function on clearing all contact data in the hive.
  Future<void> clearContact() async {
    await _data.clear();
  }

  //Function to read contacts that is stored in the hive.
  List<Contact>? fetchContactData() {
    List<Contact> contacts = [];
    if (_data.isNotEmpty) {
      contacts = _data.values.toList();
      return contacts;
    }
    return null;
  }
}

class PersonalData {
  //Reference for our Hive Box that is opened in main.dart
  final Box<MyContact> _myData = Hive.box<MyContact>('MyContacts');

  //Instance getter for getting personalData
  bool get isFilled  => _myData.isNotEmpty;

  //Function to get personal data.
  MyContact? fetchPersonalData() {
    if (_myData.isNotEmpty) {
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
    if (_myData.isNotEmpty) {
      await _myData.putAt(0, newContact);
      print('Data was updated');
    }
  }

  //Function to remove a certain indexed contact in the hive.
  Future<void> deletePersonalContact(int index) async {
    if (_myData.isNotEmpty) {
      await _myData.deleteAt(index);
      print('Datas has been removed');
    }
  }
}

class QuickCallDataRecord {
  final Box<QuickCallList> _list = Hive.box<QuickCallList>('QuickCalls');

  int get length => _list.length;
  bool get content => _list.isNotEmpty;
  ValueListenable<Box> get listenables => _list.listenable();

  List<QuickCallList>? fetchData() {
    List<QuickCallList>? qcList = [];

    if(_list.isNotEmpty){
      qcList = _list.values.toList();
      return qcList;
    }
    return null;
  }

  Future<void> addDataToList(QuickCallList recipient) async {
    await _list.add(recipient);
    print("Recipient added to QuickCall List...");
  }

  Future<void> removeDataToList(int index) async {
    if(_list.isNotEmpty){
      await _list.delete(index);
      print("$index QuickCall Data Removed...");
    }
  }

  Future<void> clearListData() async {
    await _list.clear();

  }
}
