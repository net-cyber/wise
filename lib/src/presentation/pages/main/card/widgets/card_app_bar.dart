import 'package:flutter/material.dart';

class CardAppBar extends StatelessWidget {
  const CardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      pinned: true,
      expandedHeight: 60,
      collapsedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Cards',
          style: TextStyle(
           
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}