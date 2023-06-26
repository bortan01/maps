import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "250.55 USD",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Visibility(
            visible: false,
            replacement: _BtnTarjeta(),
            child: _BtnAppleAndGooglePay(),
          )
        ],
      ),
    );
  }
}

class _BtnAppleAndGooglePay extends StatelessWidget {
  const _BtnAppleAndGooglePay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Visibility(
            visible: Platform.isAndroid,
            replacement: const Icon(
              FontAwesomeIcons.apple,
              color: Colors.white,
            ),
            child: const Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            'Pay',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

class _BtnTarjeta extends StatelessWidget {
  const _BtnTarjeta({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: const [
          Icon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.white,
          ),
          SizedBox(width: 15),
          FittedBox(
            child: Text(
              'Pagar',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
