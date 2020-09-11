import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTitleText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: Colors.black,
);

const kLightColor = Color(0xFFFFB74D);

const kDarkColor = Color(0xFFFF8A65);

const kBackgroundColor = Colors.blueGrey;

const kRightBubbleBorder = BorderRadius.only(
  topLeft: Radius.circular(30),
  bottomLeft: Radius.circular(30),
  bottomRight: Radius.circular(30),
);

const kLeftBubbleBorder = BorderRadius.only(
  topRight: Radius.circular(30),
  bottomLeft: Radius.circular(30),
  bottomRight: Radius.circular(30),
);
