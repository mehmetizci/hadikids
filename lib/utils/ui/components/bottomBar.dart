import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:haydikids/config/languages.dart';
import 'package:haydikids/core/bubble_bottom_bar.dart';

class BubbleNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;

  BubbleNavigationBar({@required this.currentIndex, @required this.onItemTap});
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
      child: BubbleBottomBar(
        hasNotch: true,
        opacity: 0.9,
        hasInk: true,
        currentIndex: currentIndex,
        // iconSize: 24,
        onTap: (int index) => onItemTap(index),
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                8)), //border radius doesn't work when the notch is enabled.
        elevation: 20,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              EvaIcons.homeOutline,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: Icon(
              EvaIcons.homeOutline,
              color: Theme.of(context).cardColor,
            ),
            title: Text(Languages.of(context).labelHome,
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              EvaIcons.searchOutline,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: Icon(
              EvaIcons.searchOutline,
              color: Theme.of(context).cardColor,
            ),
            title: Text(Languages.of(context).labelSearch,
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              EvaIcons.personAddOutline,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: Icon(
              EvaIcons.personAddOutline,
              color: Theme.of(context).cardColor,
            ),
            title: Text(Languages.of(context).labelProfile,
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          ),
          BubbleBottomBarItem(
            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              EvaIcons.settingsOutline,
              color: Theme.of(context).iconTheme.color,
            ),
            activeIcon: Icon(
              EvaIcons.settingsOutline,
              color: Theme.of(context).cardColor,
            ),
            title: Text(Languages.of(context).labelSettings,
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 16,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2)),
          )
        ],
      ),
    );
  }
}
