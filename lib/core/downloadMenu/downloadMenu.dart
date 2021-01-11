// Flutter
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haydikids/core/downloadMenu/components/homeMenu.dart';
import 'package:haydikids/core/downloadMenu/components/loadingMenu.dart';

// Internal
import 'package:haydikids/core/downloadMenu/components/videoMenu.dart';
import 'package:haydikids/core/downloadMenu/components/audioMenu.dart';
import 'package:haydikids/config/languages.dart';

import 'package:haydikids/core/youtube/youtubeExtractor.dart';
import 'package:haydikids/provider/configProvider.dart';
import 'package:haydikids/provider/downloadsProvider.dart';
import 'package:haydikids/provider/managerProvider.dart';
import 'package:haydikids/utils/ui/snackbar.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum CurrentDownloadMenu { Home, Audio, Video, Loading }

class DownloadMenu extends StatefulWidget {
  final StreamManifest streamManifest;

  final Video videoDetails;
  final String videoUrl;
  final scaffoldState;
  DownloadMenu(
      {this.streamManifest,
      this.videoDetails,
      this.videoUrl,
      this.scaffoldState});
  @override
  _DownloadMenuState createState() => _DownloadMenuState();
}

class _DownloadMenuState extends State<DownloadMenu>
    with TickerProviderStateMixin {
  // Current Download Menu Sub-Menu
  CurrentDownloadMenu currentDownloadMenu;

  // Download Menu StreamManifest
  StreamManifest manifest;
  Video details;

  @override
  void initState() {
    currentDownloadMenu = CurrentDownloadMenu.Loading;
    super.initState();
    if (widget.streamManifest == null) {
      initStreamManifest();
    } else {
      manifest = widget.streamManifest;
      details = widget.videoDetails;
      setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
    }
  }

  void initStreamManifest() async {
    VideoId videoId = VideoId(VideoId.parseVideoId(widget.videoUrl));
    manifest = await YoutubeExtractor().getStreamManifest(videoId);
    details = await YoutubeExtractor().getVideoDetails(videoId);
    setState(() => currentDownloadMenu = CurrentDownloadMenu.Home);
  }

  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return WillPopScope(
      onWillPop: () {
        manager.youtubeExtractor.killIsolates();
        return Future.value(true);
      },
      child: AnimatedSize(
        vsync: this,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
        child: _currentDownloadMenuWidget(),
      ),
    );
  }

  // Current Menu Widget
  Widget _currentDownloadMenuWidget() {
    Widget returnWidget;
    switch (currentDownloadMenu) {
      case CurrentDownloadMenu.Home:
        returnWidget = DownloadMenuHome(
          onBack: () => Navigator.pop(context),
          onAudioTap: () =>
              setState(() => currentDownloadMenu = CurrentDownloadMenu.Audio),
          onVideoTap: () =>
              setState(() => currentDownloadMenu = CurrentDownloadMenu.Video),
        );
        break;
      case CurrentDownloadMenu.Audio:
        returnWidget = Container(
          child: AudioDownloadMenu(
            audioList: manifest.audioOnly.sortByBitrate().reversed.toList(),
            onBack: () =>
                setState(() => currentDownloadMenu = CurrentDownloadMenu.Home),
            onDownload: (list) => _initializeDownload(list),
          ),
        );
        break;
      case CurrentDownloadMenu.Video:
        returnWidget = Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: VideoDownloadMenu(
            videoList: manifest.videoOnly.sortByVideoQuality(),
            onOptionSelect: (list) => _initializeDownload(list),
            audioSize:
                manifest.audioOnly.withHighestBitrate().size.totalMegaBytes,
            onBack: () =>
                setState(() => currentDownloadMenu = CurrentDownloadMenu.Home),
          ),
        );
        break;
      case CurrentDownloadMenu.Loading:
        returnWidget = Container(
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: LoadingDownloadMenu(),
        );
        break;
    }
    return returnWidget;
  }

  void _initializeDownload(dynamic configList) async {
    DownloadsProvider downloadsProvider =
        Provider.of<DownloadsProvider>(context, listen: false);
    downloadsProvider.handleVideoDownload(
        language: Languages.of(context),
        config: Provider.of<ConfigProvider>(context, listen: false),
        manifest: manifest,
        videoDetails: details,
        data: configList);
    Navigator.of(context).pop();
    if (widget.scaffoldState != null) {
      AppSnack.showSnackBar(
          icon: EvaIcons.cloudDownloadOutline,
          title: "Download started...",
          message: "${details.title}",
          context: context,
          scaffoldKey: widget.scaffoldState);
    }
  }
}
