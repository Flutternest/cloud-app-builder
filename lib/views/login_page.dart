import 'package:automation_wrapper_builder/core/constants/app_paths.dart';
import 'package:automation_wrapper_builder/core/router/app_router.dart';
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

  bool isPasswordVisible = false;

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
                  Image.asset(AppPaths.logo),
                  verticalSpaceLarge,
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
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                  ),
                  verticalSpaceRegular,
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_emailCtrl.text.trim() == 'admin@awabuilder.com' &&
                            _passCtrl.text.trim() == 'admin123') {
                          AppRouter.navigateToPage(AppRoutes.menuPage);
                        } else {
                          showSnackBar(context,
                              message:
                                  'Invalid credentials. Please check your email and password.',
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              color: Colors.red);
                        }
                      }
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
