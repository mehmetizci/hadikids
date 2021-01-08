import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:haydikids/config/languages.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;
  AppBottomNavigationBar(
      {@required this.currentIndex, @required this.onItemTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border(top: BorderSide(color: Colors.grey[400].withOpacity(0.1))),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              spreadRadius: 0.1,
              blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
          backgroundColor: Theme.of(context).cardColor,
          currentIndex: currentIndex,
          selectedLabelStyle: TextStyle(
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2),
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2),
          iconSize: 22,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).iconTheme.color,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => onItemTap(index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline),
                label: Languages.of(context).labelHome),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.cloudDownloadOutline),
                label: Languages.of(context).labelDownloads),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.musicOutline),
                label: Languages.of(context).labelMedia),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.dotsHorizontal),
                label: Languages.of(context).labelMore)
          ]),
    );
  }
}
