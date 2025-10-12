import 'package:contact_manager/functions/globals.dart';
import 'package:contact_manager/utils/app_button.dart';
import 'package:flutter/material.dart';

class EmptyListNotice extends StatelessWidget {
  final VoidCallback? function; 

  const EmptyListNotice({
    super.key,
    required this.function,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 0)
                      )
                    ],
                  ),
                  width: 320,
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('List is currently Empty...'),
                        const SizedBox(height: 50,),
                        AppButton(onPressedEvent: function, content: const Text('ADD CONTACT?'))
                      ],
                    )
                  ),
                ),
              )
            ],
          );
  }
}