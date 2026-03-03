import 'package:contact_manager/functions/globals.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressedEvent;
  final Widget? content;
  final Color? buttonColor;

  const AppButton({
    super.key,
    required this.onPressedEvent,
    required this.content,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedEvent,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        foregroundColor: defaultTextColor,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      child: content,
    );
  }
}

class CircularAppButton extends StatelessWidget {
  final VoidCallback? onPressedEvent;
  final Widget? content;

  const CircularAppButton({
    super.key,
    required this.onPressedEvent,
    required this.content,
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedEvent,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10.0)
      ),
      child: content,
    );
  }
}

class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressedEvent;
  final Widget content;
  const AppIconButton({
    super.key,
    required this.onPressedEvent,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressedEvent,
      style: IconButton.styleFrom(
        foregroundColor: defaultIconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      icon: content
    );
  }
}