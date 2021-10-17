import 'package:flutter/material.dart';

import 'package:client/pages/authenticate/signin_form.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool register = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25.0),
              _buildTitle(),
              const SizedBox(height: 50.0),
              SignInForm(register),
              const SizedBox(height: 80.0),
              _buildToggle()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    String title = register ? 'Create a new account' : 'Welcome to New Parent';
    String subtitle =
        register ? 'Sign up to get started:' : 'Sign in to continue:';

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildToggle() {
    String label =
        register ? 'Already have an account? ' : 'Don\'t have an account? ';
    String buttonLabel = register ? 'Sign In' : 'Register Now';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.deepPurple.shade400,
          ),
          onPressed: () => setState(() => register = !register),
          child: Text(
              buttonLabel,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              )
          ),
        ),
      ],
    );
  }
}
