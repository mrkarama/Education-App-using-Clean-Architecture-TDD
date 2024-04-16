import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        try {
          context.pop();
          didPop = false;
        } catch (_) {
          didPop = true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Icon(
          context.themeData.platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
      ),
    );
  }
}
