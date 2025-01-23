import 'package:flutter/material.dart';
import 'package:wise/src/presentation/pages/main/card/widgets/action_buttons.dart';
import 'package:wise/src/presentation/pages/main/card/widgets/card_app_bar.dart';
import 'package:wise/src/presentation/pages/main/card/widgets/card_carousel.dart';
import 'package:wise/src/presentation/pages/main/card/widgets/card_number.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CardAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardCarousel(),
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CardNumber(),
                      SizedBox(height: 40),
                      ActionButtons(context:  context),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}