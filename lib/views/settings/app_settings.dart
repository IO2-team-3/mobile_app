import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_config.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends StatelessWidget {
  AppSettings({super.key, required this.sharedPref});

  final SharedPreferences sharedPref;
  final String _currentServer = ApiConfig.server;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: ApiConfig.apiUrls.length,
        itemBuilder: (_, index) {
          String serverName = ApiConfig.apiUrls.keys.elementAt(index);
          return ListTile(
            title: Text(
              '$serverName (${ApiConfig.apiUrls[serverName]})',
              overflow: TextOverflow.ellipsis,
            ),
            tileColor: _currentServer == serverName ? Colors.blue : null,
            onTap: () {
              sharedPref.setString('server', serverName);
              Restart.restartApp();
            },
          );
        },
      ),
    );
  }
}
