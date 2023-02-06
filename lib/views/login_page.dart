import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:automation_wrapper_builder/core/constants/app_paths.dart';
import 'package:automation_wrapper_builder/core/router/app_router.dart';
import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_padding.dart';
import 'package:automation_wrapper_builder/exceptions/http_exception.dart';
import 'package:automation_wrapper_builder/repositories/builds_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controllers/core/theme_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isDarkTheme = ref.watch(themeBrightnessProvider) == Brightness.dark;
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
                  Image.asset(isDarkTheme ? AppPaths.logoDark : AppPaths.logo),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await ref.read(builderRepositoryProvider).login(
                              email: _emailCtrl.text.trim(),
                              password: _passCtrl.text.trim());

                          ref.read(prefsProvider).setBool("isLoggedIn", true);
                          AppRouter.navigateAndRemoveUntil(AppRoutes.menuPage);
                        } on HttpException catch (e) {
                          if (e.statusCode == 401) {
                            showSnackBar(context,
                                message:
                                    'Invalid credentials. Please check your email and password.',
                                icon: const Icon(Icons.error,
                                    color: Colors.white),
                                color: Colors.red);
                          }
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
