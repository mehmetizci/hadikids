import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haydikids/provider/managerProvider.dart';
import 'package:haydikids/screens/homeScreen/components/shimmerListView.dart';
import 'package:haydikids/screens/homeScreen/components/videoTile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (manager.youtubeSearchResults.isNotEmpty) {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: manager.youtubeSearchResults.length,
          itemBuilder: (context, index) {
            if (index == manager.youtubeSearchResults.length - 2) {
              if (manager.searchStreamRunning == false) {
                manager.updateYoutubeSearchResults();
              }
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 12 : 0),
              child: VideoTile(
                searchItem: manager.youtubeSearchResults[index],
              ),
            );
          });
    } else {
      return ShimmerHomePageListView();
    }
  }
}
