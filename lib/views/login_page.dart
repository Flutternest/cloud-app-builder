import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailCtrl,
                validator: AppUtils.emailValidate,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              verticalSpaceRegular,
              TextFormField(
                controller: _passCtrl,
                validator: AppUtils.passwordValidate,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              verticalSpaceRegular,
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                label: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
