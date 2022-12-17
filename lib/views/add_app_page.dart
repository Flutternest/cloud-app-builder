import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import '../core/widgets/app_padding.dart';

class AddAppPage extends StatelessWidget {
  const AddAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add App",
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
            const AddAppForm(),
          ],
        ),
      ),
    );
  }
}

class AddAppForm extends StatefulWidget {
  const AddAppForm({super.key});

  @override
  State<AddAppForm> createState() => _AddAppFormState();
}

class _AddAppFormState extends State<AddAppForm> {
  final _formKey = GlobalKey<FormState>();
  final _appNameController = TextEditingController();
  final _bundleIdController = TextEditingController();
  final _colorController = TextEditingController();
  final _websiteUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                if (value == null) return "Please enter a valid hex color code";
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
                      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$')
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
          verticalSpaceMedium,
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    leading: const Icon(Icons.check_circle_outline),
                    backgroundColor: Colors.greenAccent,
                    content: const Text(
                        "App added successfully. You'll get an email when it's ready"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              }
            },
            label: const Text("Add App"),
          ),
        ],
      ),
    );
  }
}
