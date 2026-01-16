import 'package:contact_manager/functions/call_function.dart';
import 'package:contact_manager/utils/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../data/database.dart';
import '../../../data/models/Contact.dart';
import '../../../functions/barrel.dart';
import '../../../utils/widgets/app_button.dart';
import '../../../utils/widgets/field_entry/user_field_entry.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
//import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ViewContactPage extends StatefulWidget {
  final Contact contact;
  late bool isBeingModified;

  ViewContactPage({
    super.key,
    required this.contact,
    required this.isBeingModified,
    });

  @override
  State<ViewContactPage> createState() => _ViewContactPageState();
}

class _ViewContactPageState extends State<ViewContactPage> {
  RecipientData record = RecipientData();

  var box = Hive.box<QuickCallList>('QuickCalls');  

  late TextEditingController _recipientName;
  late TextEditingController _recipientPhoneNumber;
  late TextEditingController _recipientEmailAddress;
  late TextEditingController _recipientAddress;
  late TextEditingController _recipientRelation;

  MakeCall call = MakeCall();

  @override
  void initState() {
    super.initState();
    _recipientName = TextEditingController(text: widget.contact.recipientName);
    _recipientPhoneNumber = TextEditingController(text: widget.contact.recipientPhoneNumber);
    _recipientEmailAddress = TextEditingController(text: widget.contact.recipientEmailAddress);
    _recipientAddress = TextEditingController(text: widget.contact.recipientAddress);
    _recipientRelation = TextEditingController(text: widget.contact.recipientRelation);
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
        record.updateContact(widget.contact, contact);  
      });
      Navigator.popAndPushNamed(context, '/home');  
      disposeControllerData();
    }     
  }

  void deleteContactData(){
    setState(() {
      record.deleteContact(widget.contact);
    });
    disposeControllerData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C O N T A C T   I N F O '),
        leading: IconButton(onPressed: (){
          Navigator.popAndPushNamed(context, '/home');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          if (!widget.isBeingModified) ...[
            AppIconButton(onPressedEvent: (){
              setState(() {
                widget.isBeingModified = !widget.isBeingModified;
              });
            }, content: const Icon(Icons.edit)),
            AppIconButton(onPressedEvent: (){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('REMOVE CONTACT DATA?'),
                  content: const Text('You are currently attempting to remove this data, are you sure about this?'),
                  actions: [
                    AppButton(onPressedEvent: (){
                      Navigator.pop(context);
                    }, content: const Text('CANCEL')),
                    AppButton(onPressedEvent: (){
                      deleteContactData();
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, "/home");
                    }, content: const Text('CONFIRM', style: TextStyle(color: Colors.red),)),
                  ],
                );
              });
            }, content: const Icon(Icons.delete))
          ]
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: defaultColor,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ContactProfile(name: widget.contact.recipientName, radius: 15,),
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
              
              SizedBox(height: (widget.isBeingModified) ? 100 : 100,),
              
              (!widget.isBeingModified) ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularAppButton(
                      onPressedEvent: (){
                        try {
                          call.openMessage(widget.contact.recipientPhoneNumber);  
                        } catch (e) {
                          showErrorDialog(
                            context, 
                            'Something went wrong!', 
                            "Unknown Exception: $e"
                            );
                        }
                      }, 
                      content: const Icon(Icons.message)),
                  ),

                  SizedBox(
                    height: 75,
                    width: 75,
                    child: CircularAppButton(
                      onPressedEvent: (){
                        try {
                          call.makePhoneCall(widget.contact.recipientPhoneNumber);  
                        } catch (e) {
                          showErrorDialog(
                            context, 
                            'Something went wrong!', 
                            "Unknown Exception: $e"
                            );
                        }
                      }, 
                      content: const Icon(Icons.phone)),
                  ),

                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularAppButton(
                      onPressedEvent: (){

                      }, 
                      content: const Text('')),
                  ),
                ],
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
        ),
      )
    );
  }
}