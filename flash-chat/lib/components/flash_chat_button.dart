import 'package:flutter/material.dart';

class FlashChatButton extends StatelessWidget {
  const FlashChatButton({
    super.key, 
    required this.title, // Question: why do we need the required keyword when the properties are clearly not optional?? in particular with "sound null safety" ?
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onTap,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  final String title;
  final Function() onTap;
  final Color color;
}
