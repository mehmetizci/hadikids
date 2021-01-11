import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:haydikids/config/languages.dart';
import 'package:haydikids/screens/homeScreen/components/roundTile.dart';

class VideoEngagement extends StatelessWidget {
  final int likeCount;
  final int dislikeCount;
  final int viewCount;
  final String videoUrl;
  final Function onSaveToFavorite;
  VideoEngagement(
      {@required this.likeCount,
      @required this.dislikeCount,
      @required this.viewCount,
      @required this.videoUrl,
      @required this.onSaveToFavorite});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Likes Counter
        RoundTile(
          icon:
              Icon(MdiIcons.thumbUp, color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(likeCount),
            style: TextStyle(fontFamily: "Varela", fontSize: 10),
          ),
        ),
        // Dislikes Counter
        RoundTile(
          icon: Icon(MdiIcons.thumbDown,
              color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(dislikeCount),
            style: TextStyle(fontFamily: "Varela", fontSize: 10),
          ),
        ),
        //
        RoundTile(
          icon: Icon(EvaIcons.eye, color: Theme.of(context).iconTheme.color),
          text: Text(
            NumberFormat.compact().format(viewCount),
            style: TextStyle(fontFamily: "Varela", fontSize: 10),
          ),
        ),
        // Channel Button
        RoundTile(
            icon:
                Icon(MdiIcons.heart, color: Theme.of(context).iconTheme.color),
            text: Text(
              "Favorite",
              style: TextStyle(fontFamily: "Varela", fontSize: 10),
            ),
            onPressed: onSaveToFavorite),
        // Share button
        RoundTile(
          icon: Icon(EvaIcons.share, color: Theme.of(context).iconTheme.color),
          text: Text(
            Languages.of(context).labelShare,
            style: TextStyle(fontFamily: "Varela", fontSize: 10),
          ),
          onPressed: () {
            Share.share(videoUrl);
          },
        ),
      ],
    );
  }
}
