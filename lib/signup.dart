import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key, required this.onSignup});

  final Function(Map<String, String> user) onSignup;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // super.dispose();
  }

  void _signupHandler(context) {
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

    onSignup({
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
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
              onPressed: () => _signupHandler(context),
              child: const Text('Signup'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Click here to login!'),
            ),
          ],
        ),
      ),
    );
  }
}
