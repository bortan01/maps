import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import '../models/tarjeta_credito.dart';
import '../widgets/total_pay_button.dart';

class TarjetaScreen extends StatelessWidget {
  const TarjetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tarjeta = TarjetaCredito(
        cardNumberHidden: '5555',
        cardNumber: '5555555555554444',
        brand: 'mastercard',
        cvv: '213',
        expiracyDate: '01/25',
        cardHolderName: 'Melissa Flores');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagar'),
      ),
      body: Stack(
        children: [
          const Center(),
          Hero(
            tag: tarjeta.cardNumber,
            child: CreditCardWidget(
              cardNumber: tarjeta.cardNumberHidden,
              expiryDate: tarjeta.expiracyDate,
              cardHolderName: tarjeta.cardHolderName,
              cvvCode: tarjeta.cvv,
              showBackView: false,
              onCreditCardWidgetChange: (p0) {},
            ),
          ),
          const Positioned(
            bottom: 0,
            child: TotalPayButton(),
          )
        ],
      ),
    );
  }
}
