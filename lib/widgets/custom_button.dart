import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.color,
    this.text,
    this.onPressed,
    this.width,
    this.height,
  });

  final Color color;
  final String text;
  final Function onPressed;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 5.0,
      constraints: BoxConstraints.tightFor(width: width, height: height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      fillColor: color,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          letterSpacing: .25,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
