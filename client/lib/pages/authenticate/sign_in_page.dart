import 'package:flutter/material.dart';
import 'package:client/widgets/google_signup_button_widget.dart';

class SignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return buildSignUp();
  }

  Widget buildSignUp() {
    return Column(
      children: [
        const Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal:20),
            width: 175,
            child: const Text(
              'Welcome to New Parent\'s Login Page!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Spacer(),
        GoogleSignupButtonWidget(),
        const SizedBox(height: 12),
        const Text(
          'Login to continue',
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
      ],
    );
  }
}