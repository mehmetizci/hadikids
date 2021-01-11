// Flutter
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:haydikids/config/languages.dart';
import 'package:haydikids/core/nativeMethods.dart';

// Internal
import 'package:haydikids/screens/libraryScreen/components/settings/columnTile.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsColumnTile(
      title: "General",
      icon: Icons.architecture_rounded,
      children: <Widget>[
        FutureBuilder(
            future: DeviceInfoPlugin().androidInfo,
            builder: (context, AsyncSnapshot<AndroidDeviceInfo> info) {
              if (info.hasData && info.data.version.sdkInt > 29) {
                return ListTile(
                  title: Text(
                    Languages.of(context).labelAndroid11Fix,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                      Languages.of(context).labelAndroid11FixJustification,
                      style: TextStyle(fontSize: 12)),
                  onTap: () {
                    NativeMethod.requestAllFilesPermission();
                  },
                );
              } else {
                return Container();
              }
            })
      ],
    );
  }
}
