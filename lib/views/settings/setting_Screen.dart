import 'package:evika/utils/colors.dart';
import 'package:evika/views/settings/settingvm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final SettingVM vm = Get.put(SettingVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingVM>(builder: (vm) {
      return Scaffold(
          // backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            foregroundColor: Colors.black,
            elevation: 0.3,
            title: const Text('SETTING',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  // fontFamily: 'sans-serif-light',
                  // color: Colors.black
                )),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                // color: Colors.black,
                size: 22.0,
              ),
            ),
          ),
          body: SettingsList(
              lightTheme: const SettingsThemeData(
                settingsListBackground: Colors.white,
                dividerColor: Colors.white70,
              ),
              sections: [
                SettingsSection(
                  title: const Text('Appearance'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Language'),
                      value: const Text('English'),
                      leading: const Icon(Icons.language),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Use System Theme'),
                      leading: const Icon(Icons.phone_android),
                      initialValue: vm.theme,
                      onToggle: (value) {
                        vm.theme = value;
                        vm.update();
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Security Settings'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Security'),
                      value: const Text('Fingerprint'),
                      leading: const Icon(Icons.lock),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile(
                      // title: const Text('Security'),
                      title: const Text('Change Password'),
                      leading: const Icon(Icons.key_sharp),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Use fingerprint'),
                      leading: const Icon(Icons.fingerprint),
                      initialValue: false,
                      onToggle: (value) {
                        vm.fingerprint = value;
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Privacy and security'),
                  tiles: [
                    SettingsTile(
                      title: const Text('Privacy Ploicy'),
                      value: const Text('Konw our privacy policy'),
                      leading: const Icon(Icons.security),
                      onPressed: (BuildContext context) {},
                    ),
                    SettingsTile(
                      title: const Text('Clear browsing data'),
                      value:
                          const Text("Clear histroy, cookies, cache and more"),
                      leading: const Icon(Icons.web),
                    ),
                  ],
                ),
              ]));
    });
  }
}
