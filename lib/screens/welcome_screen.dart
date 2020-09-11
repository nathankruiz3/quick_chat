import 'package:flutter/material.dart';
import 'package:quick_chat/util/constants.dart';
import 'package:quick_chat/widgets/custom_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );

    animation = ColorTween(begin: Colors.white70, end: kBackgroundColor)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/lightning.png'),
                    height: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, right: 14.0),
                  child: ColorizeAnimatedTextKit(
                    text: ['Quick Chat'],
                    textStyle: kTitleText,
                    colors: [
                      Colors.black,
                      kDarkColor,
                      kLightColor,
                      Colors.black,
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Hero(
              tag: 'leftButton',
              child: CustomButton(
                height: 40,
                color: kLightColor,
                text: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
            SizedBox(height: 10),
            Hero(
              tag: 'rightButton',
              child: CustomButton(
                height: 40,
                color: kDarkColor,
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
