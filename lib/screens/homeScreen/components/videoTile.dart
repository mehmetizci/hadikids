// Flutter
import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_fade/image_fade.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
//import 'package:haydikids/core/downloadMenu/downloadMenu.dart';
import 'package:haydikids/core/models/channelLogo.dart';

// Internal
import 'package:haydikids/provider/managerProvider.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:haydikids/provider/preferencesProvider.dart';
import 'package:haydikids/config/routes/video.dart';
import 'package:haydikids/utils/ui/animations/blurPageRoute.dart';
import 'package:haydikids/utils/ui/components/popupMenu.dart';
import 'package:haydikids/utils/ui/dialogs/loadingDialog.dart';
import 'package:haydikids/utils/ui/snackbar.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:haydikids/core/models/youtube/video.dart';

class VideoTile extends StatelessWidget {
  final Video searchItem;
  final bool enableSaveToWatchLater;
  final bool enableSaveToFavorites;
  final Function() onDelete;
  VideoTile(
      {@required this.searchItem,
      this.enableSaveToFavorites = true,
      this.enableSaveToWatchLater = true,
      this.onDelete});
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return InkWell(
      onTap: () async {
        List<Video> relatedVideos;
        if (manager.currentHomeTab == HomeScreenTab.Favorites) {
          relatedVideos = prefs.favoriteVideos;
        } else if (manager.currentHomeTab == HomeScreenTab.WatchLater) {
          relatedVideos = prefs.watchLaterVideos;
        }
        manager.updateMediaInfoSet(searchItem, relatedVideos);
        Navigator.push(
            context,
            BlurPageRoute(
                blurStrength: prefs.enableBlurUI ? 20 : 0,
                slideOffset: Offset(0.0, 10.0),
                builder: (_) {
                  if (searchItem is Video) {
                    return YoutubePlayerVideoPage(
                        url: searchItem.id,
                        thumbnailUrl: searchItem.thumbnailUrl);
                  } else {
                    return Container();
                  }
                }));
      },
      child: Ink(
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Column(
          children: <Widget>[
            FutureBuilder<String>(
                future: _getThumbnailLink(),
                builder: (context, snapshot) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Hero(
                        tag: searchItem.id + "player",
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Transform.scale(
                                scale: searchItem is Video ? 1.1 : 1.0,
                                child: FadeInImage(
                                  fadeInDuration: Duration(milliseconds: 200),
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: snapshot.hasData
                                      ? NetworkImage(snapshot.data)
                                      : MemoryImage(kTransparentImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
                  child: FutureBuilder<String>(
                      future: _getChannelLogoUrl(context),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        {
                          return Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).cardColor),
                          );
                        }
                      }),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${searchItem.title}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${NumberFormat.compact().format(searchItem.views)} views",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(0.4),
                              fontSize: 11),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ),
                if (searchItem is Video)
                  FlexiblePopupMenu(
                    items: [
                      "Share",
                      "Copy Link",
                      "Download",
                      onDelete != null ? "Remove" : "",
                      enableSaveToFavorites ? "Add to Favorites" : "",
                      enableSaveToWatchLater ? "Add to Watch Later" : ""
                    ],
                    onItemTap: (String value) async {
                      switch (value) {
                        case "Share":
                          Share.share(
                              "https://www.youtube.com/watch?v=${searchItem.id}");
                          break;
                        case "Copy Link":
                          String link =
                              "https://www.youtube.com/watch?v=${searchItem.id}";
                          Clipboard.setData(ClipboardData(text: link));
                          final scaffold = Scaffold.of(context);
                          AppSnack.showSnackBar(
                              icon: Icons.copy,
                              title: "Link copied to Clipboard",
                              duration: Duration(seconds: 2),
                              context: context,
                              scaffoldKey: scaffold);
                          break;
                        case "Download":
                          showModalBottomSheet<dynamic>(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                              ),
                              clipBehavior: Clip.antiAlias,
                              context: context,
                              builder: (context) {
                                String url =
                                    "http://youtube.com/watch?v=${searchItem.id}";
                                return Wrap(
                                  children: [
                                    /* DownloadMenu(
                                      videoUrl: url,
                                      scaffoldState: manager
                                          .libraryScaffoldKey.currentState,
                                    ),*/
                                  ],
                                );
                              });
                          break;
                        case "Remove":
                          onDelete();
                          break;
                        case "Add to Favorites":
                          Video videoToSave;
                          videoToSave = searchItem;

                          List<Video> videos = prefs.favoriteVideos;
                          videos.add(videoToSave);
                          prefs.favoriteVideos = videos;
                          AppSnack.showSnackBar(
                              icon: EvaIcons.heartOutline,
                              title: "Video added to Favorites",
                              context: context,
                              scaffoldKey: Scaffold.of(context));
                          break;
                        case "Add to Watch Later":
                          Video videoToSave;
                          videoToSave = searchItem;

                          List<Video> videos = prefs.watchLaterVideos;
                          videos.add(videoToSave);
                          prefs.watchLaterVideos = videos;
                          AppSnack.showSnackBar(
                              icon: EvaIcons.clockOutline,
                              title: "Video added to Watch Later",
                              context: context,
                              scaffoldKey: Scaffold.of(context));
                          break;
                      }
                    },
                    borderRadius: 10,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.transparent,
                      child: Icon(Icons.more_vert_rounded, size: 14),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getThumbnailLink() async {
    String link = searchItem.thumbnailUrl;
    return link;
  }

  Future<String> _getChannelLogoUrl(context) async {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);

    Video video = searchItem;

    return video.channelLogo;
  }
}
