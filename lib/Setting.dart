import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

//UI Of Settings page (However, Dark Mode works if you turn it on on your phone
// itself). Used the settings_ui package for this.
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            backgroundColor: Colors.green,
          ),
          body: SettingsList(sections: [
            SettingsSection(
                title: Text(
                  "Appearance",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.green),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    initialValue: isSwitched1,
                    leading: Icon(Icons.dark_mode_outlined),
                    title: Text("Dark theme"),
                    onToggle: (value) {
                      setState(() {
                        isSwitched1 = value;
                      });
                    },
                  ),
                  SettingsTile(
                    leading: Icon(Icons.display_settings),
                    title: Text('Display'),
                  ),
                ]),
            SettingsSection(
                title: Text(
                  "Privacy",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.green),
                ),
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text("Permissions"),
                  ),
                  SettingsTile(
                    leading: Icon(Icons.security_outlined),
                    title: Text('Security'),
                  ),
                ]),
            SettingsSection(
                title: Text(
                  "Accounts",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.green),
                ),
                tiles: <SettingsTile>[
                  SettingsTile(
                    leading: Icon(Icons.supervised_user_circle_outlined),
                    title: Text("Multiple Users"),
                  ),
                  SettingsTile(
                    leading: Icon(Icons.feedback_outlined),
                    title: Text('Feedback'),
                  ),
                ]),
          ])),
    );
  }
}