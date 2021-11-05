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
              const SizedBox(height: 30.0),
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
    String title = register ? 'Create a new account' : 'Welcome to BabyQuest';
    String subtitle =
        register ? 'Sign up to get started:' : 'Sign in to continue:';

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: Theme.of(context).textTheme.headline1),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(subtitle, style: Theme.of(context).textTheme.headline2),
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
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16.0,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => setState(() => register = !register),
          child: Text(buttonLabel,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
