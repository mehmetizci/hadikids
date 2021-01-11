// Flutter
import 'package:flutter/material.dart';
import 'package:haydikids/config/languages.dart';

// Internal
import 'package:haydikids/provider/configProvider.dart';
import 'package:haydikids/screens/libraryScreen/settings.dart';
import 'package:haydikids/screens/libraryScreen/components/quickAcessTile.dart';

// Packages
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:haydikids/screens/libraryScreen/components/haydikidsBanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigProvider config = Provider.of<ConfigProvider>(context);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // HaydiKids Banner
          HaydiKidsBanner(
            appName: config.appName,
            appVersion: config.appVersion,
          ),
          // Settings
          QuickAccessTile(
              tileIcon: Icon(EvaIcons.settingsOutline, color: Colors.redAccent),
              title: Languages.of(context).labelSettings,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsTab()));
              }),
          // Telegram Channel
          QuickAccessTile(
            tileIcon: Icon(MdiIcons.telegram, color: Colors.blue),
            title: "Telegram",
            onTap: () {
              launch("https://t.me/haydikidschannel");
            },
          ),
          // Github
          QuickAccessTile(
            tileIcon: Icon(EvaIcons.githubOutline, color: Colors.blueGrey),
            title: "GitHub",
            onTap: () {
              launch("https://github.com/HaydiKids");
            },
          ),
          // Licenses
          QuickAccessTile(
            tileIcon: Icon(EvaIcons.heartOutline, color: Colors.redAccent),
            title: Languages.of(context).labelDonate,
            onTap: () {
              launch("https://paypal.me/artixo");
            },
          ),
          // Licenses
          QuickAccessTile(
            tileIcon: Icon(MdiIcons.license, color: Colors.green),
            title: Languages.of(context).labelLicenses,
            onTap: () {
              showLicensePage(
                  applicationName: config.appName,
                  applicationIcon: Image.asset('assets/images/ic_launcher.png',
                      height: 50, width: 50),
                  applicationVersion: config.appVersion,
                  context: context);
            },
          )
        ],
      ),
    );
  }
}
