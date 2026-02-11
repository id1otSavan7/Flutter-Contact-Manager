import 'package:contact_manager/data/database.dart';
import 'package:contact_manager/data/models/Contact.dart';
import 'package:contact_manager/functions/call_function.dart';
import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/functions/helpers.dart';
import 'package:contact_manager/utils/widgets/app_button.dart';
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
    return Column(children: [
      //Context Title
      Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: defaultTextColor,
          width: 2,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Quick Calls",
              style: headerTextStyle,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (!isEdittingQC) {
                        addQuickCallData(
                            context, widget.record, widget.quickCalls);
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
                        : const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
      //Quick Call Area
      SizedBox(
        height: 100,
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          addQuickCallData(
                              context, widget.record, widget.quickCalls);
                        });
                      },
                      child: Container(
                        color: defaultColor,
                        width: 80,
                        padding: const EdgeInsets.all(2.5),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.add),
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            Text(
                              'ADD',
                              style: addTextStyle,
                            )
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
                  return InkWell(
                    onTap: () => (isEdittingQC)
                        ? showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text(
                                    "You're trying to remove something..."),
                                content: const Text(
                                    "You are trying to remove this data from your Quick Dial List. Are you sure about this?"),
                                actions: [
                                  AppButton(
                                      buttonColor: cancelButtonColor,
                                      onPressedEvent: () {
                                        Navigator.pop(context);
                                      },
                                      content: const Text("CANCEL")),
                                  AppButton(
                                      buttonColor: saveButtonColor,
                                      onPressedEvent: () {
                                        setState(() {
                                          widget.quickCalls
                                              .removeDataToList(list);
                                          if (isEdittingQC &&
                                              !widget.quickCalls.content) {
                                            isEdittingQC = false;
                                          }
                                        });
                                        Navigator.pop(context);
                                      },
                                      content: const Text(
                                        "CONFIRM",
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              );
                            })
                        : MakeCall().makePhoneCall(list.contactNumber),
                    child: Container(
                      color: Colors.white,
                      width: 80,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContactProfile(
                            name: list.contactName,
                            radius: 25,
                          ),
                          const SizedBox(
                            height: 2.5,
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
    ]);
  }
}
