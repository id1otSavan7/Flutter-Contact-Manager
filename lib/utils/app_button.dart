import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressedEvent;
  final Widget? content;

  const AppButton({
    super.key,
    required this.onPressedEvent,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressedEvent,
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
    return IconButton(onPressed: onPressedEvent, icon: content);
  }
}