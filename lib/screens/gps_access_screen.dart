import 'package:flutter/material.dart';

class GpsAccesScreen extends StatelessWidget {
  const GpsAccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccesButton(),
    );
  }
}

class EnableGpsMessage extends StatelessWidget {
  const EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Debe Habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class AccesButton extends StatelessWidget {
  const AccesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Es necesario el GPS',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          MaterialButton(
            splashColor: Colors.transparent,
            elevation: 0,
            shape: const StadiumBorder(),
            color: Colors.black,
            child: const Text(
              "Solicia Acceso",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
