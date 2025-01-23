import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';

class CardCarousel extends StatelessWidget {
  const CardCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: 260,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: index == 0 ? 16 : 0),
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage(AppConstants.wise_card),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}