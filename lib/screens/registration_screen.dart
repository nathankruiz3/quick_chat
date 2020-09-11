import 'package:flutter/material.dart';
import 'package:quick_chat/util/constants.dart';
import 'package:quick_chat/widgets/custom_button.dart';
import 'package:quick_chat/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String fullName, email, password, confirmedPassword;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Registration',
                      style: kTitleText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 24),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            padding: EdgeInsets.only(left: 14),
                            height: 200,
                            child: Image.asset('images/lightning.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomTextField(
                        hint: 'Full Name',
                        type: TextInputType.text,
                        onChanged: (value) {
                          fullName = value;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        hint: 'Email',
                        type: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        hint: 'New Password',
                        type: TextInputType.text,
                        isPassword: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        hint: 'Confirm Password',
                        type: TextInputType.text,
                        isPassword: true,
                        onChanged: (value) {
                          confirmedPassword = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'leftButton',
                      child: CustomButton(
                        width: 100,
                        height: 40,
                        color: kLightColor,
                        text: 'Reset',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Hero(
                      tag: 'rightButton',
                      child: CustomButton(
                        width: 100,
                        height: 40,
                        color: kDarkColor,
                        text: 'Submit',
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            if (confirmedPassword == password) {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              if (newUser != null) {
                                Navigator.pushNamed(context, '/chat');
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              print('Passwords do not match');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
