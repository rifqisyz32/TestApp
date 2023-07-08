import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/auth_provider.dart';

const users = const {
  'testme@gmail.com': 'testme321',
  'testme2@gmail.com': 'testme3212',
};

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint(
      'Name: ${data.name}, Password: ${data.password}',
    );
    return Future.delayed(loginTime).then(
      (_) async {
        try {
          await Provider.of<AuthProvider>(context, listen: false).logIn(
            data.name,
            data.password,
          );
          if (!users.containsKey(data.name)) {
            return 'User not exists';
          }
          if (users[data.name] != data.password) {
            return 'Password does not match';
          }
        } catch (e) {
          return e.toString();
        }

        return null;
      },
    );
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint(
      'Signup Name: ${data.name}, Password: ${data.password}',
    );
    return Future.delayed(loginTime).then(
      (_) async {
        try {
          await Provider.of<AuthProvider>(context, listen: false).signUp(
            data.name,
            data.password,
          );
        } catch (e) {
          return e.toString();
        }
        return null;
      },
    );
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then(
      (_) {
        if (!users.containsKey(name)) {
          return 'Username not exists';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Test App',

      // logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Provider.of<AuthProvider>(context, listen: false).tempData();
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
