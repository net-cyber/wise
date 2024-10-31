import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String initials;
  final String earnAmount;
  final VoidCallback? onEarnPressed;
  final VoidCallback? onNotificationPressed;

  const TopBar({
    super.key,
    required this.initials,
    required this.earnAmount,
    this.onEarnPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            initials,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onEarnPressed,
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB5EA9A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Earn \$$earnAmount'),
                ),
              ),
              IconButton(
                onPressed: onNotificationPressed,
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}