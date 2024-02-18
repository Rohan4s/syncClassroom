import 'package:flutter/material.dart';
import 'package:sync_classroom/screens/auth/register/create_account.dart';

import 'package:sync_classroom/styles/app_texts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ValueNotifier<String> errorMessage = ValueNotifier<String>('');
  final ValueNotifier<bool> processing = ValueNotifier<bool>(false);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  ValueNotifier<String?> selectedRole = ValueNotifier<String?>(null);
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

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String about = _aboutController.text;
    String role = selectedRole.value ?? '';
    String confirmPassword = _confirmPasswordController.text;
    if (email == '' || password == '' || name == '') {
      errorMessage.value = 'Please fill all the fields';
      return;
    }
    if (role == '') {
      errorMessage.value = 'Please select a role';
      return;
    }

    print('Email: $email, Password: $password');

    String message = await createAccount(
      context: context,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      role: role,
      about: about,
    );
    print(message);
    if (message == 'success' && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppTexts.loginRoute,
        (route) => false,
      );
    } else {
      errorMessage.value = message;
    }
    processing.value = false;
  }

  void proceedToLogin() async {
    Navigator.pushNamed(context, AppTexts.loginRoute);
  }

  @override
  void initState() {
    print('asd');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Register Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/hat.jpg'),
              height: 200,
              width: 200,
            ),
            TextField(
              style: inputTextStyle,
              controller: _nameController,
              decoration:
                  InputDecoration(labelText: 'Name', labelStyle: textStyle),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: selectedRole,
              builder: (context, value, child) {
                return DropdownButton<String>(
                  value: selectedRole.value,
                  isExpanded: true,
                  hint: const Text('Select Role'),
                  items: <String>['Student', 'Teacher'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: textStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedRole.value = value!;
                  },
                );
              },
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
            TextField(
              obscureText: true,
              style: inputTextStyle,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  labelText: 'Confirm Password', labelStyle: textStyle),
            ),
            TextField(
              obscureText: true,
              style: inputTextStyle,
              controller: _aboutController,
              decoration: InputDecoration(
                  labelText: 'About Yourself', labelStyle: textStyle),
            ),
            _errorMessage(),
            ElevatedButton(
              onPressed: register,
              style: submitButtonStyle,
              child: Text(
                'Register',
                style: submitTextStyle,
              ),
            ),
            TextButton(
              onPressed: proceedToLogin,
              child: const Text('Already have an account? Login!'),
            ),
            ValueListenableBuilder(
                valueListenable: processing,
                builder: (BuildContext context, bool value, Widget? child) {
                  return value
                      ? const CircularProgressIndicator()
                      : const SizedBox();
                }),
          ],
        ),
      ),
    );
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
}
