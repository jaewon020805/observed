import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observed/core/theme/theme_provider.dart';
import 'package:observed/core/theme/app_theme.dart';
import 'package:observed/core/theme/app_text_styles.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final customColors = Theme.of(context).custom;

    return Scaffold(
      backgroundColor: customColors.bg,
      appBar: AppBar(
        backgroundColor: customColors.bg,
        elevation: 0,
        title: Text(
          "Settings",
          style: AppTextStyles.h3.copyWith(color: customColors.text1),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              "Dark Mode",
              style: AppTextStyles.m2.copyWith(color: customColors.text1),
            ),
            subtitle: Text(
              "Toggle between light and dark theme",
              style: AppTextStyles.m4.copyWith(color: customColors.text2),
            ),
            value: themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              ref.read(themeProvider.notifier).toggleTheme(value);
            },
            activeThumbColor: customColors.text1,
          ),
          ListTile(
            title: Text(
              "System Theme",
              style: AppTextStyles.m2.copyWith(color: customColors.text1),
            ),
            onTap: () {
              ref.read(themeProvider.notifier).setSystemTheme();
            },
            trailing: themeMode == ThemeMode.system
                ? Icon(Icons.check, color: customColors.text1)
                : null,
          ),
        ],
      ),
    );
  }
}
