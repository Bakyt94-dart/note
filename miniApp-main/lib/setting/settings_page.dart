
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();

  
}

class _SettingsPage extends State<SettingsPage> {
  late SharedPreferences _preferences;
  bool _isDarkThemeOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();

    _setPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
        backgroundColor: _isDarkThemeOn ? Colors.black : Colors.white,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Темная тема"),
              Spacer(),
              Switch(
                value: _isDarkThemeOn, 
                onChanged: (v) {
                  setState(() {
                     _isDarkThemeOn = v;
                     _setPreferences();
                  print("isDarkTheme $_isDarkThemeOn");
                  });
                })
            ],
          )
        ],
      )
    );
  }

  void _setPreferences() async {
    _preferences.setBool('isDarkTheme', _isDarkThemeOn);
    _preferences.setInt('progress', 50);
    _preferences.setString('phoneNumber', "996700000000");
  }

  void _getPreferences() async {
    _preferences = await SharedPreferences.getInstance();

    _isDarkThemeOn = _preferences.getBool("isDarkTheme") ?? false;
    final progress = _preferences.getInt("progress") ?? 0;
    final phoneNumber = _preferences.getString("phoneNumber") ?? "none";

    print("isDarkThemeOn $_isDarkThemeOn");
    print("progress $progress");
    print("phoneNumber $phoneNumber");
  }
}