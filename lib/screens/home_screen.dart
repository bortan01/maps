import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mapas/data/tarjetas.dart';
import 'package:mapas/helpers/navegar_fade_in.dart';
import 'package:mapas/screens/tarjeta_screen.dart';

import '../widgets/total_pay_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagar'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            top: 200,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.8),
              itemCount: tarjetas.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final tarjeta = tarjetas[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, navegarFadeIn(context, const TarjetaScreen()));
                  },
                  child: Hero(
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
                );
              },
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
