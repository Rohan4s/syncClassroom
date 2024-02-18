import 'package:flutter/material.dart';
import 'package:sync_classroom/screens/auth/login/login.dart';

import 'package:sync_classroom/styles/app_texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');
  final ValueNotifier<bool> processing = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      errorMessage.value = 'Email and password cannot be empty';
      return;
    }
    errorMessage.value = '';
    processing.value = true;
    String email = _emailController.text;
    String password = _passwordController.text;
    print('Email: $email, Password: $password');

    String message = await login(
      email,
      password,
      context,
    );

    processing.value = false;
    if (message == 'success' && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppTexts.homeRoute,
        (route) => false,
      );
    } else {
      errorMessage.value = message;
    }
  }

  Future<void> proceedToRegister() async {
    Navigator.pushNamed(context, AppTexts.registerRoute);
  }

  Widget _errorMessage() {
    return ValueListenableBuilder<String>(
      valueListenable: errorMessage,
      builder: (context, value, child) {
        return Text(
          value,
          style: const TextStyle(color: Colors.red),
        );
      },
    );
  }

  final TextStyle submitTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    // fontWeight: FontWeight.w300,
  );
  final TextStyle inputTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    // fontWeight: FontWeight.w300,
  );
  final ButtonStyle submitButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(color: Colors.blue),
      ),
    ),
  );
  final TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome!',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              const Image(
                image: AssetImage('assets/hat.jpg'),
                height: 200,
                width: 200,
              ),
              TextField(
                style: inputTextStyle,
                controller: _emailController,
                decoration:
                    InputDecoration(labelText: 'Email', labelStyle: textStyle),
              ),
              TextField(
                obscureText: true,
                style: inputTextStyle,
                controller: _passwordController,
                decoration:
                    InputDecoration(labelText: 'Password', labelStyle: textStyle),
              ),
              _errorMessage(),
              ElevatedButton(
                onPressed: signIn,
                style: submitButtonStyle,
                child: Text(
                  'Login',
                  style: submitTextStyle,
                ),
              ),
              TextButton(
                onPressed: proceedToRegister,
                child: const Text('Don\'t have an account? Register!'),
              ),
              ValueListenableBuilder(
                valueListenable: processing,
                builder: (BuildContext context, bool value, Widget? child) {
                  return value
                      ? const CircularProgressIndicator()
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
