import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      body: DefaultAppPadding(
        child: Form(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveSizingConfig.instance.breakpoints.tablet,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome back",
                    style: textTheme(context).headlineMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceSmall,
                  Text(
                    "Please login to continue",
                    style: textTheme(context).bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceMedium,
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
        ),
      ),
    );
  }
}
