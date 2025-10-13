import 'package:contact_manager/utils/profile.dart';
import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/models/Contact.dart';
import '../functions/barrel.dart';
import '../utils/app_button.dart';
import '../utils/user_field_entry.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ViewContactPage extends StatefulWidget {
  final int index;
  late bool isBeingModified;
  final String? recipientName;
  final String? recipientPhoneNumber;
  final String? recipientEmailAddress;
  final String? recipientAddress;
  final String? recipientRelation;

  ViewContactPage({
    super.key,
    required this.index,
    required this.isBeingModified,
    required this.recipientName,
    required this.recipientPhoneNumber,
    required this.recipientEmailAddress,
    required this.recipientAddress,
    required this.recipientRelation,
    });

  @override
  State<ViewContactPage> createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  late TextEditingController _recipientName;
  late TextEditingController _recipientPhoneNumber;
  late TextEditingController _recipientEmailAddress;
  late TextEditingController _recipientAddress;
  late TextEditingController _recipientRelation;

  @override
  void initState() {
    super.initState();
    _recipientName = TextEditingController(text: widget.recipientName);
    _recipientPhoneNumber = TextEditingController(text: widget.recipientPhoneNumber);
    _recipientEmailAddress = TextEditingController(text: widget.recipientEmailAddress);
    _recipientAddress = TextEditingController(text: widget.recipientAddress);
    _recipientRelation = TextEditingController(text: widget.recipientRelation);
  }

  @override
  void dispose() {
    _recipientName.dispose();
    _recipientPhoneNumber.dispose();
    _recipientEmailAddress.dispose();
    _recipientAddress.dispose();
    _recipientRelation.dispose();
    super.dispose();
  }

  void submitModifiedData() {
    if (_recipientPhoneNumber.text.isEmpty){
      showErrorDialog(
        context, 
        'AN IMPORTANT FIELD WAS LEFT EMPTY', 
        'Are you trying to add a contact? A contact info atleast must have a Phone Number...'
      );
    } else {
      final contact = Contact(
        recipientName: isDataNull(_recipientName.text, 'Unknown Recipient'), 
        recipientPhoneNumber: _recipientPhoneNumber.text, 
        recipientEmailAddress: isDataNull(_recipientEmailAddress.text, 'No data recorded.'), 
        recipientAddress: isDataNull(_recipientAddress.text, 'No data recorded.'), 
        recipientRelation: isDataNull(_recipientRelation.text, 'No data recorded.'),);
      setState(() {
        Book().updateContact(widget.index, contact);  
      });
      Navigator.popAndPushNamed(context, '/home');  
      disposeControllerData();
    }     
  }

  void deleteContactData(int index){
    setState(() {
      Book().deleteContact(index);
    });
    disposeControllerData();

  }

  Future<void> makePhoneCall(String? contactNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: contactNumber);
    if (await canLaunchUrl(phoneUri)){
      await launchUrl(phoneUri);
    } else {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: const Text('SOMETHING WENT WRONG...'),
          content: const Text('Unable to make a call, something went wrong.'),
          actions: [
            AppButton(onPressedEvent: (){
              Navigator.pop(context);
            }, content: const Text('O K A Y '))
          ],
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('C O N T A C T   I N F O '),
          leading: IconButton(onPressed: (){
            Navigator.popAndPushNamed(context, '/home');
          }, icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            if (!widget.isBeingModified) ...[
              CircularAppButton(onPressedEvent: (){
                setState(() {
                  widget.isBeingModified = !widget.isBeingModified;
                });
              }, content: const Icon(Icons.edit)),
              CircularAppButton(onPressedEvent: (){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('REMOVE CONTACT DATA?'),
                    content: const Text('You are currently attempting to remove this data, are you sure about this?'),
                    actions: [
                      AppButton(onPressedEvent: (){
                        Navigator.pop(context);
                      }, content: const Text('CANCEL')),
                      AppButton(onPressedEvent: (){
                        deleteContactData(widget.index);
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, "/home");
                      }, content: const Text('CONFIRM')),
                    ],
                  );
                });
              }, content: const Icon(Icons.delete))
            ]
          ],
        ),
        body: Container(
          color: defaultColor,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: ContactProfile(name: widget.recipientName),
                ),
              ),

              const SizedBox(
                height: 25,
              ),
                  
              UserEntryField(
                isBeingModified: !widget.isBeingModified, 
                name: _recipientName, 
                phoneNumber: _recipientPhoneNumber, 
                email: _recipientEmailAddress, 
                address: _recipientAddress, 
                relation: _recipientRelation
              ),
              
              SizedBox(height: (widget.isBeingModified) ? 100 : 50,),
              
              (!widget.isBeingModified) ?
              Center(
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: CircularAppButton(
                    onPressedEvent: (){
                      makePhoneCall(widget.recipientPhoneNumber);
                    }, 
                    content: const Icon(Icons.phone)),
                ),
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(onPressedEvent: (){
                    setState(() {
                      widget.isBeingModified = false;
                    });
                  }, content: const Text('CANCEL')),
                  AppButton(onPressedEvent: (){
                    submitModifiedData();
                  }, content: const Text('SAVE')),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}