import 'package:flutter/material.dart';

import 'package:client/pages/authenticate/authenticate.dart';
import 'package:client/pages/main/main_wrapper.dart';
import 'package:client/services/auth_service.dart';

class Wrapper extends StatelessWidget {
  Widget _builder(contest, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasData) {
      return const MainWrapper(); // main pages
    } else if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong!'));
    } else {
      return const Authenticate(); // authentication pages
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: AuthService().appUser,
        builder: _builder,
      ),
    );
  }
}
