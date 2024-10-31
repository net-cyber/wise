import 'package:flutter/material.dart';

class AppleWalletButton extends StatelessWidget {
  const AppleWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          children: [
            Icon(
              Icons.apple,
              size: 24,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              'pay',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Add to Apple Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              size: 28,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}