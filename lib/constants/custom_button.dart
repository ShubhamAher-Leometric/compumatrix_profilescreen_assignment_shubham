import 'package:flutter/material.dart';
import 'color_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 49,
      decoration: BoxDecoration(
        color: buttonColor ?? appPrimaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appPrimaryColor, // Set default to transparent
          width: 1, // Set border width
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontFamily: 'Abel',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.7,
          ),
        ),
      ),
    );
  }
}
