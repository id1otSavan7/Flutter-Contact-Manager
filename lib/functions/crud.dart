import 'package:contact_manager/functions/func_barrel.dart';

List<Map <dynamic, dynamic>> contacts = [
  {'name' : 'Lance Andrei Sombillo', 
  'phoneNumber' : '09123456789', 
  'eMail' : 'user.example@email.com', 
  'homeAddress' : 'Pampanga, Philippines', 
  'relation' : 'Friend'},
];

void addContacts(){
  
  contacts.add({
    'name': isDataNull(recipientName.text, 'Unknown Recipient'),
    'phoneNumber' : recipientPhoneNumber.text, 
    'eMail' : isDataNull(recipientEmailAddress.text, 'No Data Recorded'),
    'homeAddress' : isDataNull(recipientAddress.text, 'No Data Recorded'),
    'relation' : isDataNull(recipientRelation.text, 'No Data Recorded'),
  });

  recipientName.clear();
  recipientPhoneNumber.clear();
  recipientEmailAddress.clear();
  recipientAddress.clear();
  recipientRelation.clear();
}

void removeContact(data){
  contacts.remove(data);
  print('Data removed...');
}

void updateContact(int index, Map<dynamic, dynamic> modifiedData){
  contacts[index] = modifiedData;
  print('Data was updated');
}