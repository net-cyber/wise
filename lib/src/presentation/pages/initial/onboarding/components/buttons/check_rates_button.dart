import 'package:flutter/material.dart';
class CheckRatesButton extends StatelessWidget {
  const CheckRatesButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Check our rates',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
