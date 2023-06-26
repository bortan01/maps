import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showLoadingMessage(BuildContext context, {required String mensaje}) async {
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
            children: [
              const SizedBox(height: 10),
              Text(mensaje),
              const SizedBox(height: 15),
              const LinearProgressIndicator(),
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

Future<void> showAlerta(BuildContext context, {required String mensaje}) async {
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
            children: [
              const SizedBox(height: 10),
              Text(mensaje),
              const SizedBox(height: 15),
              const LinearProgressIndicator(),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Espere por favor"),
        content: const CupertinoActivityIndicator(),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      );
    },
  );
}
