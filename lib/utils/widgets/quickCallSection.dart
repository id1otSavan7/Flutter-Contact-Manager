import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/call_function.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/functions/helpers.dart';
import 'package:contact_manager/utils/widgets/profile.dart';
import 'package:flutter/material.dart';

class BuildQuickCallSection extends StatefulWidget {
  final QuickCallDataRecord quickCalls;
  final RecipientData record;
  

  const BuildQuickCallSection({
    super.key,
    required this.quickCalls,
    required this.record,
    });

  @override
  State<BuildQuickCallSection> createState() => _BuildQuickCallSectionState();
}

class _BuildQuickCallSectionState extends State<BuildQuickCallSection> {
  bool isEdittingQC = false;
  bool showTools = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Context Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quick Calls",
              style: TextStyle(fontSize: 18),
            ),
            Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (!isEdittingQC) {
                          addQuickCallData(context, widget.record, widget.quickCalls);
                        }
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                            isEdittingQC = !isEdittingQC;
                        });
                      },
                      icon: (isEdittingQC)
                          ? const Icon(Icons.close)
                          : const Icon(Icons.edit))
                ],
              )
          ],
        ),
        //Quick Call Area
        SizedBox(
          height: 125,
          width: double.infinity,
          child: ValueListenableBuilder(
              valueListenable: widget.quickCalls.listenables,
              builder: (context, box, _) {
                List<QuickCallList> lists =
                    box.values.toList().cast<QuickCallList>();
                lists.sort((a, b) => a.contactName!
                    .toLowerCase()
                    .compareTo(b.contactName!.toLowerCase()));
                if (!widget.quickCalls.content) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            addQuickCallData(context, widget.record, widget.quickCalls);
                          });
                        },
                        child: Container(
                          color: defaultColor,
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(8),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.add),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('add')
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                    final list = lists[index];
                    return GestureDetector(
                      onTap: () => (isEdittingQC)
                          ? setState(() {
                              widget.quickCalls.removeDataToList(index);
                              if(isEdittingQC && !widget.quickCalls.content){
                                isEdittingQC = false;
                              }
                            })
                          : MakeCall().makePhoneCall(list.contactNumber),
                      child: Container(
                        color: Colors.white,
                        width: 100,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContactProfile(
                              name: list.contactName,
                              radius: 30,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(getFirstName(list.contactName) ?? '')
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        )
      ]
    );
  }
}


