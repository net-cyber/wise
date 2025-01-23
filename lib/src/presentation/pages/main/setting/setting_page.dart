import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/provider/login_provider.dart';
import 'package:wise/src/presentation/riverpod/provider/app_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appNotifier = ref.watch(appProvider.notifier);
    final loginNotifier = ref.watch(loginProvider.notifier);
    final themeState = ref.watch(appProvider);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                 
                    const SizedBox(width: 16),
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Settings List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Notification Section
                  _buildNotificationSection(context),
                  const SizedBox(height: 24),

                  // Main Settings
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.dark_mode_outlined,
                      title: themeState.isDarkMode ? 'Light Mode' : 'Dark Mode',
                      onTap: () {},
                      trailing: Switch(
                        value: themeState.isDarkMode,
                        onChanged: (value) {
                          appNotifier.changeTheme(value);
                        },
                      ),
                    ),
                    SettingItem(
                      icon: Icons.star_outline,
                      title: 'Rate App',
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.share_outlined,
                      title: 'Share App',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Legal Settings
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.lock_outline,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.description_outlined,
                      title: 'Terms and Conditions',
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.cookie_outlined,
                      title: 'Cookies Policy',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Support Settings
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.mail_outline,
                      title: 'Contact',
                      onTap: () {},
                    ),
                    SettingItem(
                      icon: Icons.feedback_outlined,
                      title: 'Feedback',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Logout Section
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        loginNotifier.logout(context);
                      },
                      textColor: Colors.red,
                      iconColor: Colors.red,
                    ),
                  ]),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.notifications_outlined),
              SizedBox(width: 16),
              Text(
                'Notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<SettingItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        children: items.map((item) => _buildSettingTile(context, item)).toList(),
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context, SettingItem item) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      textColor: Theme.of(context).colorScheme.onSurface,
      iconColor: Theme.of(context).colorScheme.onSurface,
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(
        item.icon,
        color: item.iconColor,
        size: 24,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: item.trailing,
      onTap: item.onTap,
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;
  final Widget? trailing;

  SettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.trailing,
  });
}