import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required String message,
    required VoidCallback onOk ,
    Duration duration = const Duration(milliseconds: 2000),
    String btnLabel = 'ok',
    Key? key,
  }) : super(
          key: key,
          content: Text(message),
          duration: duration,
          action: SnackBarAction(
            label: btnLabel,
            onPressed: onOk,
            
          ),
        );
}
