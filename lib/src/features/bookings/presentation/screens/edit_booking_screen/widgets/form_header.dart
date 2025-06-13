import 'package:flutter/material.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    super.key,
    required this.onClose,
    this.isEditing = false,
  });

  final VoidCallback onClose;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Row(
      key: const Key(Keys.headerSection),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isEditing ? Strings.editBooking : Strings.newBooking,
          style: theme.textTheme.h4,
        ),
        IconButton(
          key: const Key(Keys.closeButton),
          icon: Icon(
            Icons.close,
            color: theme.colorScheme.mutedForeground,
          ),
          onPressed: onClose,
          tooltip: Strings.closeDialog,
        ),
      ],
    );
  }
}
