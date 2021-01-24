import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haydikids/provider/managerProvider.dart';
import 'package:haydikids/screens/homeScreen/components/shimmerListView.dart';
import 'package:haydikids/screens/homeScreen/components/videoTile.dart';

class HomePageEducation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    if (manager.homeEducationVideoList.isNotEmpty) {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: manager.homeEducationVideoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16, top: index == 0 ? 12 : 0),
              child: VideoTile(
                searchItem: manager.homeEducationVideoList[index],
              ),
            );
          });
    } else {
      return ShimmerHomePageListView();
    }
  }
}
