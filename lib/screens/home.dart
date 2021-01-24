// Flutter
import 'package:flutter/material.dart';
import 'package:haydikids/provider/configProvider.dart';
import 'package:haydikids/provider/preferencesProvider.dart';
import 'package:haydikids/screens/homeScreen/components/homePageFavoritesEmpty.dart';
import 'package:haydikids/screens/homeScreen/components/homePageWatchLaterEmpty.dart';
import 'package:haydikids/screens/homeScreen/homeAppBar.dart';
import 'package:haydikids/screens/homeScreen/homeCategoryList.dart';
import 'package:haydikids/config/routes/components/video/shimmer/shimmerVideoTile.dart';

// Internal
import 'package:haydikids/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:haydikids/screens/homeScreen/pages/favorites.dart';
import 'package:haydikids/screens/homeScreen/pages/homePage.dart';
import 'package:haydikids/screens/homeScreen/pages/music.dart';
import 'package:haydikids/screens/homeScreen/pages/trending.dart';
import 'package:haydikids/screens/homeScreen/pages/watchLater.dart';
import 'package:haydikids/utils/ui/components/searchHistory.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    ManagerProvider manager =
        Provider.of<ManagerProvider>(context, listen: false);
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      int tabIndex = controller.index;
      if (tabIndex == 0) {
        manager.currentHomeTab = HomeScreenTab.Home;
      } else if (tabIndex == 1) {
        manager.currentHomeTab = HomeScreenTab.Education;
      } else if (tabIndex == 2) {
        manager.currentHomeTab = HomeScreenTab.Music;
      } else if (tabIndex == 3) {
        manager.currentHomeTab = HomeScreenTab.Favorites;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    ConfigProvider config = Provider.of<ConfigProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: [
          NestedScrollView(
            physics: BouncingScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                HomePageAppBar(
                    openSearch: manager.showSearchBar,
                    tabController: controller,
                    onSearch: () {
                      controller.animateTo(0);
                    })
              ];
            },
            body: Column(
              children: [
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[600].withOpacity(0.2)),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    HomePage(),
                    HomePageEducation(),
                    HomePageMusic(),
                    HomePageFavorites(),
                    // HomePageWatchLater()
                  ]),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: manager.showSearchBar
                  ? Column(
                      children: [
                        Container(
                          height: kToolbarHeight + 48,
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: SearchHistoryList(onItemTap: (String item) {
                              manager.searchBarFocusNode.unfocus();
                              manager.youtubeSearchQuery = item;
                              controller.animateTo(0);
                              manager.updateYoutubeSearchResults(
                                  updateResults: true);
                              Future.delayed(Duration(milliseconds: 100), () {
                                manager.showSearchBar = false;
                              });
                              if (item.length > 1) {
                                Future.delayed(
                                    Duration(milliseconds: 400),
                                    () => config
                                        .addStringtoSearchHistory(item.trim()));
                              }
                            }),
                          ),
                        ),
                      ],
                    )
                  : Container())
        ],
      ),
    );
  }
}
