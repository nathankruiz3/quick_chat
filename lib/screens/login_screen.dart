import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:quick_chat/util/constants.dart';
import 'package:quick_chat/widgets/custom_text_field.dart';
import 'package:quick_chat/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email, password;
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
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Log In',
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
                        messageTextController: emailController,
                        hint: 'Email',
                        type: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        messageTextController: passController,
                        hint: 'Password',
                        type: TextInputType.text,
                        isPassword: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'leftButton',
                      child: CustomButton(
                        width: 100,
                        height: 40,
                        color: kLightColor,
                        text: 'Register',
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                      ),
                    ),
                    SizedBox(width: 35),
                    Hero(
                      tag: 'rightButton',
                      child: CustomButton(
                        width: 100,
                        height: 40,
                        color: kDarkColor,
                        text: 'Sign In',
                        onPressed: () async {
                          emailController.clear();
                          passController.clear();
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.pushNamed(context, '/chat');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
