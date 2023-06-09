import 'package:auth/home.dart';
import 'package:auth/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final List<Map<String, String>> _users = [
    {
      'email': 'sujan@test.com',
      'password': 'password',
    },
  ];
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // super.dispose();
  }

  void _loginHandler(context) {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Form is empty'),
            content: const Text('Please enter your email and password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Okay!'),
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, String> _user = _users.firstWhere(
      (user) {
        return user['email'] == _emailController.text.trim() &&
            user['password'] == _passwordController.text.trim();
      },
      orElse: () => {
        // do nothing
      },
    );

    if (_user.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: const Text('Incorrect email and password!'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Okay'))
            ]),
      );
    } else {
      //success
      _emailController.text = '';
      _passwordController.text = '';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: _user,
          ),
        ),
      );
    }
  }

  void _navigateSignupScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(onSignup: _signupHandler),
      ),
    );
  }

  void _signupHandler(Map<String, String> user) {
    _users.add(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loginHandler(context),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => _navigateSignupScreen(context),
              child: const Text('Click here to sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
