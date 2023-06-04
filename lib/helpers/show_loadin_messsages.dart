import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showLoadingMessage(BuildContext context) async {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Espere por favor",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 10),
              Text("Calcualando Ruta"),
              SizedBox(height: 15),
              CircularProgressIndicator.adaptive(
                strokeWidth: 3,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const CupertinoAlertDialog(
        title: Text("Espere por favor"),
        content: CupertinoActivityIndicator(),
      );
    },
  );
}
