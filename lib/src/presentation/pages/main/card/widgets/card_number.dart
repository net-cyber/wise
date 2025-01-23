import 'package:flutter/material.dart';
import 'dart:ui';

class CardNumber extends StatelessWidget {
  const CardNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            'Digital card ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        
         
        ],
      ),
    );
  }
}