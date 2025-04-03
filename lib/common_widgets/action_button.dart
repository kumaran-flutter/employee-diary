import 'package:flutter/material.dart';

import '../styles/styles.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onCancelPressed;
  final VoidCallback? onSavePressed;

  const ActionButton({super.key, this.onCancelPressed, this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStateProperty.all(AppColors.lightBlue),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          onPressed: onCancelPressed,
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.twitterBlue),
          ),
        ),
        const SizedBox(width: 16), // Add spacing between buttons
        ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStateProperty.all(AppColors.twitterBlue),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          onPressed: onSavePressed,
          child: const Text(
            'Save',
            style: TextStyle(
              color: AppColors.whiteColor,
            ), // Replace with AppColors.whiteColor
          ),
        ),
      ],
    );
  }
}
