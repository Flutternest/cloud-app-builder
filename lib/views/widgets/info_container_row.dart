import 'package:automation_wrapper_builder/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/hover_builder.dart';

class InfoContainerRow extends StatelessWidget {
  const InfoContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        InfoContainer(contentType: "Total Variants", value: "22"),
        // horizontalSpaceRegular,
        // InfoContainer(contentType: "Total Variants", value: "22"),
      ],
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer(
      {Key? key, required this.contentType, required this.value})
      : super(key: key);

  final String contentType;
  final String value;

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      child: Container(
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.width / 10,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: theme(context).colorScheme.inversePrimary,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    value,
                    style: textTheme(context).displaySmall!.copyWith(
                          color: theme(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                contentType,
                style: textTheme(context).titleSmall!.copyWith(
                      color: theme(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
