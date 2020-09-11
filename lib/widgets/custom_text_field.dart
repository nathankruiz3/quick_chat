import 'package:flutter/material.dart';
import 'package:quick_chat/util/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.hint,
      this.type,
      this.isPassword,
      this.onChanged,
      this.messageTextController});

  final String hint;
  final Function onChanged;
  final TextInputType type;
  final bool isPassword;
  final TextEditingController messageTextController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageTextController,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      obscureText: isPassword == null ? false : isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kDarkColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
