// lib/features/settings/presentation/pages/settings_page.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor:
            AppColors.primary, // Sesuaikan warna AppBar jika diperlukan
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Pengaturan Notifikasi
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifikasi'),
            trailing: Switch(
              value: themeProvider.notificationsEnabled,
              onChanged: (value) {
                themeProvider.toggleNotifications(value);
              },
            ),
          ),
          Divider(),
          // Pengaturan Bahasa
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Bahasa'),
            subtitle: Text('Indonesia'),
            onTap: () {
              // Implementasi perubahan bahasa jika diperlukan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fitur ini belum tersedia.')),
              );
            },
          ),
          Divider(),
          // Tentang Aplikasi
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Tentang'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Nutriti-On',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Nutriti-On',
              );
            },
          ),
          Divider(),
          // Reset Data
          ListTile(
            leading: Icon(Icons.restore),
            title: Text('Reset Data'),
            onTap: () {
              // Implementasi reset data jika diperlukan
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Reset Data'),
                  content: Text('Apakah Anda yakin ingin mereset semua data?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implementasi reset data
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil direset.')),
                        );
                      },
                      child: Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
          // Tambahkan pengaturan lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
