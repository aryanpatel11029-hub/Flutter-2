import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  String _selectedLanguage = 'English';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Language'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        children: ['English', 'Hindi', 'Gujarati'].map((lang) {
          return SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedLanguage = lang);
              Navigator.pop(ctx);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(lang, style: const TextStyle(fontSize: 15)),
                  if (_selectedLanguage == lang)
                    const Icon(Icons.check, color: Color(0xFF4F39E3)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK', style: TextStyle(color: Color(0xFF4F39E3))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1E293B),
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Dark Mode Switch
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: Switch.adaptive(
              value: _darkMode,
              activeTrackColor: const Color(0xFF4F39E3),
              onChanged: (val) {
                setState(() => _darkMode = val);
              },
            ),
          ),
          Divider(color: Colors.grey.shade100, height: 1),

          // Language
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Language',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedLanguage,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
            onTap: _showLanguageDialog,
          ),
          Divider(color: Colors.grey.shade100, height: 1),

          // Privacy & Security
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Privacy & Security',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF94A3B8),
            ),
            onTap: () {
              _showInfoDialog(
                'Privacy & Security',
                'Your data and transactions are encrypted with 256-bit security. We do not sell your personal information.',
              );
            },
          ),
          Divider(color: Colors.grey.shade100, height: 1),

          // Help & Support
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF94A3B8),
            ),
            onTap: () {
              _showInfoDialog(
                'Help & Support',
                'Need assistance? Contact us at support@reread.com or call +91 98246 53755.',
              );
            },
          ),
          Divider(color: Colors.grey.shade100, height: 1),

          // Terms of Service
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF94A3B8),
            ),
            onTap: () {
              _showInfoDialog(
                'Terms of Service',
                'By using ReRead, you agree to our community standards, fair book condition assessment, and terms of service.',
              );
            },
          ),
          Divider(color: Colors.grey.shade100, height: 1),

          // App Version
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'App Version',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            trailing: Text(
              'v1.2.0',
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
