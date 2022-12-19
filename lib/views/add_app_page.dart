import 'package:automation_wrapper_builder/controllers/core/theme_provider.dart';
import 'package:automation_wrapper_builder/controllers/selected_menu_controller.dart';
import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/widgets/app_padding.dart';

class AppPackage {
  final String name;
  final String bundleId;
  final String websiteUrl;
  final String iconUrl;
  final String color;
  final String versionCode;
  final String versionNumber;
  final String toEmail;

  AppPackage({
    required this.name,
    required this.color,
    required this.versionCode,
    required this.versionNumber,
    required this.bundleId,
    required this.websiteUrl,
    required this.iconUrl,
    required this.toEmail,
  });
}

class AddAppPage extends StatelessWidget {
  const AddAppPage({super.key, this.isUpdate = false, this.appPackage});

  final bool isUpdate;
  final AppPackage? appPackage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isUpdate ? "Update App " : "Create App",
              style: textTheme(context).titleLarge!.copyWith(),
            ),
            verticalSpaceRegular,
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      "https://www.facebook.com/images/fb_icon_325x325.png",
                    ),
                  ),
                  Positioned(
                    right: -5,
                    bottom: -5,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final pickedPath = await AppUtils.getFromGallery();
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceRegular,
            const Center(child: Text("Resolution: 514x514 (1:1 aspect ratio)")),
            verticalSpaceRegular,
            AddAppForm(
              appPackage: appPackage,
              isUpdate: isUpdate,
            ),
          ],
        ),
      ),
    );
  }
}

class AddAppForm extends ConsumerStatefulWidget {
  const AddAppForm({super.key, this.appPackage, this.isUpdate = false});
  final AppPackage? appPackage;
  final bool isUpdate;

  @override
  ConsumerState<AddAppForm> createState() => _AddAppFormState();
}

class _AddAppFormState extends ConsumerState<AddAppForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _appNameController =
      TextEditingController(text: widget.appPackage?.name);
  late final _bundleIdController =
      TextEditingController(text: widget.appPackage?.bundleId);
  late final _colorController =
      TextEditingController(text: widget.appPackage?.color);
  late final _websiteUrlController =
      TextEditingController(text: widget.appPackage?.websiteUrl);
  late final _versionNumberController =
      TextEditingController(text: widget.appPackage?.versionNumber);
  late final _versionController =
      TextEditingController(text: widget.appPackage?.versionCode);
  late final _toEmailController = TextEditingController(
      text: widget.appPackage?.toEmail ?? "admin@awabuilder.com");

  bool isLoading = false;

  @override
  void dispose() {
    _appNameController.dispose();
    _bundleIdController.dispose();
    _colorController.dispose();
    _websiteUrlController.dispose();
    _versionNumberController.dispose();
    _versionController.dispose();
    _toEmailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _appNameController,
              validator: AppUtils.fieldEmpty,
              decoration: const InputDecoration(
                labelText: "App Name",
                hintText: "Enter App Name",
              ),
            ),
            verticalSpaceRegular,
            TextFormField(
              controller: _bundleIdController,
              validator: (value) {
                if (value == null) {
                  return "Please enter a valid app bundle identifier";
                }
                if (value.isEmpty) {
                  return 'Please enter a valid app bundle identifier';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Bundle ID",
                hintText: "Ex: com.betpredictions.app",
              ),
            ),
            verticalSpaceRegular,
            Tooltip(
              message:
                  "Do not include the Hash (#) symbol while entering the color code",
              child: TextFormField(
                controller: _colorController,
                validator: (value) {
                  if (value == null) {
                    return "Please enter a valid hex color code";
                  }
                  if (value.isEmpty) {
                    return 'Please enter a valid hex color code';
                  }
                  // Check that the value is a valid hex color code (e.g. FF0000)
                  if (!RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(value)) {
                    return 'Invalid hex color code';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Color (HEX)",
                  hintText: "Ex: FFF000",
                ),
              ),
            ),
            verticalSpaceRegular,
            TextFormField(
              controller: _websiteUrlController,
              validator: (value) {
                if (value == null) return "Please enter a valid website URL";
                if (value.isEmpty) {
                  return 'Please enter a valid website URL';
                }
                // Check that the value is a valid website URL
                if (!RegExp(
                        r'^(https?:\/\/){1}([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$')
                    .hasMatch(value)) {
                  return 'Invalid website URL';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Website URL",
                hintText: "Ex: https://betpredictions.app/user_abc",
              ),
            ),
            verticalSpaceRegular,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _versionController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid version code (ex: 1.0.0)";
                      }

                      if (value.isEmpty) {
                        return 'Please enter a version code (ex: 1.0.0)';
                      }
                      // Check the format of the input.
                      // Android version codes are typically in the form 'x.y.z', where x, y, and z are integers.
                      // iOS version codes are typically in the form 'x.y.z', where x, y, and z are integers.
                      if (!RegExp(r'^\d+\.\d+\.\d+$').hasMatch(value)) {
                        return 'Please enter a valid version code (ex: 1.0.0)';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Version Code",
                      hintText: "Ex: 1.0.0",
                    ),
                  ),
                ),
                horizontalSpaceRegular,
                Expanded(
                  child: TextFormField(
                    controller: _versionNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid version/build number";
                      }
                      if (value.isEmpty) {
                        return 'Please enter a valid version/build number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Version/Build Number",
                      hintText: "Ex: 12",
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceRegular,
            TextFormField(
              controller: _toEmailController,
              validator: AppUtils.emailValidate,
              decoration: const InputDecoration(
                labelText: "Email address to send",
                hintText: "admin@betpredictions.com",
              ),
            ),
            verticalSpaceMedium,
            ElevatedButton.icon(
              icon: isLoading
                  ? const SizedBox(
                      height: 20, width: 20, child: CircularProgressIndicator())
                  : Icon(widget.isUpdate ? Icons.update : Icons.add),
              label: Text(isLoading
                  ? widget.isUpdate
                      ? "Updating..."
                      : "Creating..."
                  : widget.isUpdate
                      ? "Update App"
                      : "Create App"),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);

                        setState(() => isLoading = true);
                        await Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          setState(() => isLoading = false);

                          _appNameController.clear();
                          _bundleIdController.clear();
                          _colorController.clear();
                          _websiteUrlController.clear();
                          _versionController.clear();
                          _versionNumberController.clear();
                        });

                        scaffoldMessenger.showMaterialBanner(
                          MaterialBanner(
                            leading: const Icon(Icons.check_circle_outline),
                            backgroundColor: Colors.green,
                            content: Text(
                                "App ${widget.isUpdate ? "updated" : "added"} successfully. You'll get an email when it's ready. ${!widget.isUpdate ? 'Redirecting to Dashboard...' : ""}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                        if (widget.isUpdate) {
                          ref.watch(sidebarContentProvider.notifier).state =
                              null;
                        }
                        Future.delayed(const Duration(seconds: 5), () {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();

                          ref.read(selectedMenuProvider.notifier).state =
                              SidebarMenuItem.dashboard;
                        });
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
