import 'package:flutter/material.dart';

import '../../core/utils/ui_helper.dart';
import '../../core/widgets/hover_builder.dart';

class AddNewButton extends StatelessWidget {
  const AddNewButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.width / 10,
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: theme(context).colorScheme.primary,
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.add_circle,
                      size: 50,
                      color: theme(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Add New",
                  style: textTheme(context).titleSmall!.copyWith(
                        color: theme(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
