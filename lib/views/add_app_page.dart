import 'dart:io';

import 'package:automation_wrapper_builder/controllers/core/theme_provider.dart';
import 'package:automation_wrapper_builder/controllers/selected_menu_controller.dart';
import 'package:automation_wrapper_builder/core/utils/app_utils.dart';
import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:automation_wrapper_builder/core/widgets/app_image.dart';
import 'package:automation_wrapper_builder/data/models/build_item.dart';
import 'package:automation_wrapper_builder/exceptions/http_exception.dart';
import 'package:automation_wrapper_builder/repositories/builds_repository.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_network/image_network.dart';

import '../core/widgets/app_padding.dart';

class AddAppPage extends StatefulWidget {
  const AddAppPage({super.key, this.isUpdate = false, this.buildItem});

  final bool isUpdate;
  final BuildItem? buildItem;

  @override
  State<AddAppPage> createState() => _AddAppPageState();
}

class _AddAppPageState extends State<AddAppPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.isUpdate ? "Update App " : "Create App",
              style: textTheme(context).titleLarge!.copyWith(),
            ),
            AddAppForm(
              appPackage: widget.buildItem,
              isUpdate: widget.isUpdate,
            ),
          ],
        ),
      ),
    );
  }
}

class AddAppForm extends ConsumerStatefulWidget {
  const AddAppForm({
    super.key,
    this.appPackage,
    this.isUpdate = false,
  });

  final BuildItem? appPackage;
  final bool isUpdate;

  @override
  ConsumerState<AddAppForm> createState() => _AddAppFormState();
}

class _AddAppFormState extends ConsumerState<AddAppForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _appNameController =
      TextEditingController(text: widget.appPackage?.applicationName);
  late final _bundleIdController =
      TextEditingController(text: widget.appPackage?.bundleId);
  late final _colorController =
      TextEditingController(text: widget.appPackage?.primaryColor);
  late final _websiteUrlController =
      TextEditingController(text: widget.appPackage?.websiteUrl);
  late final _versionNumberController =
      TextEditingController(text: widget.appPackage?.versionNumber);
  late final _versionController =
      TextEditingController(text: widget.appPackage?.version);
  late final _toEmailController =
      TextEditingController(text: "admin@awabuilder.com");

  Uint8List? iconBytes;
  Uint8List? keystoreBytes;
  String? uploadedKeystoreName;

  void setIconBytes(Uint8List? newBytes) {
    iconBytes = newBytes;
    setState(() {});
  }

  void setKeystoreBytes(Uint8List? newBytes, [String? newKeystoreName]) {
    keystoreBytes = newBytes;
    uploadedKeystoreName = newKeystoreName;
    setState(() {});
  }

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
    Widget appIcon;

    if (iconBytes != null) {
      appIcon = Image.memory(iconBytes!);
    } else if (widget.appPackage?.iconUrl != null &&
        widget.appPackage!.iconUrl!.isNotEmpty) {
      appIcon = AppImage(
        widget.appPackage!.iconUrl!,
        height: 100,
        width: 100,
      );
    } else {
      appIcon = const AppImage(
        'https://firebasestorage.googleapis.com/v0/b/awa-builder.appspot.com/o/uploads%2Fglobal%2Fic_launcher.png?alt=media&token=3a5a6b8c-7a0a-46e1-8222-823c66544491',
        height: 100,
        width: 100,
      );
    }

    return FocusTraversalGroup(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
                    child: appIcon,
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
                          // setIconPath(await AppUtils.getFromGallery());
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png', 'jpeg'],
                          );
                          if (result?.files != null) {
                            // setIconPath(File(result!.files.single.path!).path);
                            setIconBytes(result!.files.single.bytes!);
                          }
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
            // verticalSpaceMedium,
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey[600]!),
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text(
            //           keystoreBytes != null
            //               ? uploadedKeystoreName ?? "Keystore Uploaded."
            //               : "Upload keystore file ${widget.isUpdate ? "(leave blank to use original)" : "(if available)"}",
            //         ),
            //       ),
            //       if (keystoreBytes != null)
            //         IconButton(
            //           onPressed: () {
            //             setKeystoreBytes(null, null);
            //           },
            //           icon: const Icon(Icons.delete),
            //           color: Colors.red,
            //         )
            //       else
            //         TextButton.icon(
            //           onPressed: () async {
            //             FilePickerResult? result =
            //                 await FilePicker.platform.pickFiles(
            //               type: FileType.custom,
            //               allowedExtensions: ['jks'],
            //             );
            //             if (result?.files != null) {
            //               setKeystoreBytes(
            //                 result!.files.single.bytes,
            //                 result.files.single.name,
            //               );
            //             }
            //           },
            //           icon: const Icon(Icons.upload),
            //           label: const Text("Upload (JKS file)"),
            //         )
            //     ],
            //   ),
            // ),
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

                        try {
                          final rawData = {
                            "applicationName": _appNameController.text,
                            "bundleId": _bundleIdController.text,
                            "websiteUrl": _websiteUrlController.text,
                            "primaryColor": _colorController.text,
                            "version": _versionController.text,
                            "versionNumber": _versionNumberController.text,
                          };

                          if (iconBytes != null) {
                            debugPrint(
                                "Icon not uploaded. Asking to use default");
                          }
                          if (keystoreBytes != null) {
                            debugPrint(
                                "Keystore not uploaded. Asking to use default");
                          }

                          final filesData = {
                            if (iconBytes != null)
                              "appIcon": MultipartFile.fromBytes(iconBytes!),
                            if (keystoreBytes != null)
                              "keystore":
                                  MultipartFile.fromBytes(keystoreBytes!),
                          };

                          await ref
                              .read(buildsRepositoryProvider)
                              .addOrUpdatedNewBuild(
                                recordId: widget.isUpdate
                                    ? widget.appPackage?.uid
                                    : null,
                                rawData: rawData,
                                filesData: filesData,
                              );

                          _appNameController.clear();
                          _bundleIdController.clear();
                          _colorController.clear();
                          _websiteUrlController.clear();
                          _versionController.clear();
                          _versionNumberController.clear();

                          setIconBytes(null);
                          setKeystoreBytes(null);

                          if (!widget.isUpdate) {
                            scaffoldMessenger.showMaterialBanner(
                              MaterialBanner(
                                leading: const Icon(Icons.check_circle_outline),
                                backgroundColor: Colors.green,
                                content: Text(
                                    "App ${widget.isUpdate ? "updated" : "added"} successfully. You'll get an email when it's ready. ${!widget.isUpdate ? 'Redirecting to Dashboard...' : ""}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      scaffoldMessenger
                                          .hideCurrentMaterialBanner();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            Future.delayed(const Duration(seconds: 5), () {
                              scaffoldMessenger.hideCurrentMaterialBanner();
                              ref.read(selectedMenuProvider.notifier).state =
                                  SidebarMenuItem.dashboard;
                            });
                          } else {
                            ref.read(sidebarContentProvider.notifier).state =
                                null;
                          }
                        } on HttpException catch (e) {
                          debugPrint(
                              "Error (addOrUpdatedNewBuild | type: ${widget.isUpdate ? "update" : "new"}): ${e.message}");
                        } finally {
                          setState(() => isLoading = false);
                        }
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
