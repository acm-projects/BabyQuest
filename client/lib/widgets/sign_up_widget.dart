import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:client/widgets/google_signup_button_widget.dart';

class SignUpWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return buildSignUp();
  }

  Widget buildSignUp() {
    return Column(
      children: [
        Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal:20),
            width: 175,
            child: Text(
              'Welcome to New Parent\'s Login Page!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Spacer(),
        GoogleSignupButtonWidget(),
        SizedBox(height: 12),
        Text(
          'Login to continue',
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
      ],
    );
  }
}