import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';

class ShellPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellPage({
    super.key,
    required this.navigationShell,
  });

  void _onNavigationItemSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onNavigationItemSelected,
        backgroundColor: Colors.white,
        elevation: 0,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: Colors.transparent,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              weight: 700,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(
              Icons.credit_card,
              weight: 700,
            ),
            label: 'Card',
          ),
          NavigationDestination(
            icon: Icon(Icons.send_outlined),
            selectedIcon: Icon(
              Icons.send,
              weight: 700,
            ),
            label: 'Send',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(
              Icons.people,
              weight: 700,
            ),
            label: 'Recipients',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(
              Icons.grid_view,
              weight: 700,
            ),
            label: 'Manage',
          ),
        ],
      ),
    );
  }
}