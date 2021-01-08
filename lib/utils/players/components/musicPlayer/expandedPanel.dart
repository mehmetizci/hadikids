// Dart
import 'dart:io';
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import 'package:haydikids/utils/players/service/playerService.dart';
import 'package:haydikids/utils/players/components/musicPlayer/ui/playerBackground.dart';
import 'package:haydikids/utils/players/components/musicPlayer/ui/playerBody.dart';
import 'package:haydikids/provider/configProvider.dart';
import 'package:haydikids/provider/mediaProvider.dart';

// Packages
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:haydikids/provider/preferencesProvider.dart';

class ExpandedPlayer extends StatelessWidget {
  final PanelController controller;
  final AsyncSnapshot<ScreenState> snapshot;
  ExpandedPlayer({
    this.controller,
    this.snapshot,
  });
  @override
  Widget build(BuildContext context) {
    final screenState = snapshot.data;
    final mediaItem = screenState?.mediaItem;
    final state = screenState?.playbackState;
    final playing = state?.playing ?? false;
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    ConfigProvider config = Provider.of<ConfigProvider>(context);
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    File image = mediaProvider.artwork;
    Color dominantColor = prefs.enableBlurUI
        ? mediaProvider.dominantColor == null
            ? Colors.white
            : mediaProvider.dominantColor
        : Theme.of(context).accentColor;
    Color textColor = prefs.enableBlurUI
        ? dominantColor.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white
        : Theme.of(context).textTheme.bodyText1.color;
    Color vibrantColor = prefs.enableBlurUI
        ? mediaProvider.vibrantColor == null
            ? Colors.white
            : mediaProvider.vibrantColor
        : Theme.of(context).accentColor;
    return Scaffold(
        backgroundColor: !prefs.enableBlurUI
            ? Theme.of(context).scaffoldBackgroundColor
            : dominantColor,
        body: PlayerBackground(
            backgroundImage: File(mediaItem.artUri.replaceAll("file://", "")),
            enableBlur: prefs.enableBlurUI,
            blurIntensity: 50,
            backdropColor: prefs.enableBlurUI
                ? dominantColor
                : Theme.of(context).scaffoldBackgroundColor,
            backdropOpacity: 0.4,
            child: PlayerBody(
              controller: controller,
              playingFrom: mediaItem.album,
              textColor: textColor,
              artworkFile: image,
              vibrantColor: vibrantColor,
              playing: playing,
              mediaItem: mediaItem,
              dominantColor: dominantColor,
              state: state,
              expandArtwork: config.useExpandedArtwork,
            )));
  }
}
