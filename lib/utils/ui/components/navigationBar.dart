import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:haydikids/config/languages.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;
  final PageController tabBarController = new PageController(initialPage: 0);
  final List<Tabs> tabs = new List();

  AppBottomNavigationBar(
      {@required this.currentIndex, @required this.onItemTap});
  @override
  Widget build(BuildContext context) {
    tabs.add(Tabs(
      Icons.home,
      Languages.of(context).labelHome,
      Colors.deepPurple,
      getGradient(Colors.deepPurple),
    ));
    tabs.add(Tabs(Icons.search, Languages.of(context).labelSearchYoutube,
        Colors.pink, getGradient(Colors.pink)));
    tabs.add(Tabs(Icons.access_alarm, Languages.of(context).labelSearchYoutube,
        Colors.amber, getGradient(Colors.amber)));
    tabs.add(Tabs(Icons.settings, Languages.of(context).labelSettings,
        Colors.teal, getGradient(Colors.teal)));

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
      child: CubertoBottomBar(
          key: Key("BottomBar"),
          inactiveIconColor: Theme.of(context).cardColor,
          tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
          selectedTab: currentIndex,
          tabs: tabs
              .map((value) => TabData(
                  key: Key(value.title),
                  iconData: value.icon,
                  title: value.title,
                  tabColor: value.color,
                  tabGradient: value.gradient))
              .toList(),
          onTabChangedListener: (onItemTap, title, color) {
            tabBarController.jumpToPage(onItemTap);
          }),

      /*BottomNavigationBar(
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
          ]),*/
    );
  }
}

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

getGradient(Color color) {
  return LinearGradient(
      colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
      stops: [0.0, 0.7]);
}
