import 'package:circular_check_box/circular_check_box.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haydikids/provider/configProvider.dart';
import 'package:haydikids/provider/preferencesProvider.dart';

class MusicPlayerSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigProvider config = Provider.of<ConfigProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        children: [
          Icon(
            EvaIcons.brushOutline,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(width: 8),
          Text(
            "Player Settings",
            style: TextStyle(
                fontFamily: 'YTSans',
                color: Theme.of(context).textTheme.bodyText1.color),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expanded Artwork
          ListTile(
            title: Text(
              "Expand Artwork",
              style: TextStyle(
                  fontFamily: 'YTSans',
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.6)),
            ),
            onTap: () {
              config.useExpandedArtwork = !config.useExpandedArtwork;
            },
            trailing: CircularCheckBox(
              value: config.useExpandedArtwork,
              onChanged: (_) {
                config.useExpandedArtwork = !config.useExpandedArtwork;
              },
            ),
          ),
          ListTile(
            title: Text(
              "Artwork Rounded Corners",
              style: TextStyle(
                  fontFamily: 'YTSans',
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.6)),
            ),
            subtitle: Row(
              children: [
                Text("0"),
                Expanded(
                  child: Slider(
                    value: prefs.musicPlayerArtworkRoundCorners,
                    min: 0,
                    max: 30,
                    onChanged: (double value) {
                      prefs.musicPlayerArtworkRoundCorners = value;
                    },
                    activeColor: Theme.of(context).accentColor,
                    inactiveColor: Colors.transparent,
                  ),
                ),
                Text("30")
              ],
            ),
          )
        ],
      ),
    );
  }
}
