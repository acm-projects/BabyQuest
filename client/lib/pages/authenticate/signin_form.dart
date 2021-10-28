import 'package:client/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:client/services/auth_service.dart';

class SignInForm extends StatefulWidget {
  final bool register;

  const SignInForm(this.register, {Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  // Field values
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailAddressField(),
          const SizedBox(height: 20.0),
          _buildPasswordField(),
          const SizedBox(height: 40.0),
          _buildSignUpButton(),
          _buildGoogleSignInButton(),
        ],
      ),
    );
  }

  Widget _buildEmailAddressField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        labelText: 'Email Address',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        prefixIcon: const Icon(Icons.email),
      ),
      validator: (value) {
        return (value == null || value.isEmpty)
            ? 'Enter an email address'
            : null;
      },
      onChanged: (value) => setState(() => email = value),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        labelText: 'Password',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        prefixIcon: const Icon(Icons.lock),
      ),
      validator: (value) {
        return (value == null || value.length < 6)
            ? 'Password must be at least 6 characters long'
            : null;
      },
      onChanged: (value) => setState(() => password = value),
    );
  }

  Widget _buildSignUpButton() {
    String label = widget.register ? 'Create Account' : 'Login';

    return RoundButton(
      onPressed: () async {
        if (_formKey.currentState != null &&
            _formKey.currentState!.validate()) {
          final provider = Provider.of<AuthService>(context, listen: false);

          if (widget.register) {
            provider.registerWithEmailAndPassword(email, password);
          } else {
            provider.signInWithEmailAndPassword(email, password);
          }
        }
      },
      text: label,
    );
  }

  Widget _buildGoogleSignInButton() {
    if (widget.register) {
      return const SizedBox(height: 125.0);
    } else {
      return Column(
        children: [
          const SizedBox(height: 25.0),
          Row(children: [
            Expanded(child: Divider(color: Colors.black.withOpacity(0.5))),
            Text('   or   ',
                style: TextStyle(color: Colors.black.withOpacity(0.5))),
            Expanded(child: Divider(color: Colors.black.withOpacity(0.5))),
          ]),
          const SizedBox(height: 25.0),
          RoundButton(
            onPressed: () {
              final provider = Provider.of<AuthService>(context, listen: false);
              provider.signInWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Login with Google',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
