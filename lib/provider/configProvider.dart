// Flutter
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haydikids/core/models/channelLogo.dart';

// Internal
import 'package:haydikids/core/haydiPreferences.dart';

// Packages
import 'package:ext_storage/ext_storage.dart';
import 'package:package_info/package_info.dart';

class ConfigProvider extends ChangeNotifier {
  HaydiPreferences preferences = new HaydiPreferences();

  ConfigProvider({this.preferences}) {
    preferences = this.preferences;
    initProvider();
  }

  void initProvider() async {
    loadSavedData();
    if (_audioDownloadPath == null)
      ExtStorage.getExternalStorageDirectory().then((value) {
        _audioDownloadPath = value + "/HaydiKids";
      });
    if (_videoDownloadPath == null)
      ExtStorage.getExternalStorageDirectory().then((value) {
        _videoDownloadPath = value + "/HaydiKids";
      });
    PackageInfo.fromPlatform().then((value) {
      appName = value.appName;
      packageName = value.packageName;
      appVersion = value.version;
      buildNumber = value.buildNumber;
    });
    accentColor = preferences.getAccentColor();
    showIntroduction = preferences.showIntroductionPages();
  }

  // App Introduction
  bool showIntroduction;

  // Platform Info
  String appName;
  String packageName;
  String appVersion;
  String buildNumber;

  Color _accentColor;
  bool _systemThemeAvailable = false;
  bool _systemThemeEnabled = false;
  bool _darkThemeEnabled = false;
  bool _blackThemeEnabled = false;
  bool _enableFFmpegActionType = true;
  bool _enableVideoConvertion = false;
  // Converting audio format
  String _ffmpegActionTypeFormat = "AAC";
  // Download paths
  String _audioDownloadPath;
  String _videoDownloadPath;
  bool _enableAlbumFolder;
  // Use Youtube Webview
  bool _useYoutubeWebview = false;
  // Search History
  List<String> _searchHistory;
  Color get accentColor => _accentColor;
  bool get systemThemeAvailable => _systemThemeAvailable;
  bool get systemThemeEnabled => _systemThemeEnabled;
  bool get darkThemeEnabled => _darkThemeEnabled;
  bool get blackThemeEnabled => _blackThemeEnabled;
  bool get enableFFmpegActionType => _enableFFmpegActionType;
  bool get enableVideoConvertion => _enableVideoConvertion;
  // Converting audio format
  String get ffmpegActionTypeFormat => _ffmpegActionTypeFormat;
  // Download paths
  String get audioDownloadPath => _audioDownloadPath;
  String get videoDownloadPath => _videoDownloadPath;
  // Album Folder
  bool get enableAlbumFolder => _enableAlbumFolder;
  // Use Youtube Webview
  bool get useYoutubeWebview => _useYoutubeWebview;
  // Navigate ChannelLogo Cache
  List<ChannelLogo> _channelLogos;

  // Disclaimer Status
  bool _disclaimerAccepted;

  // Fix Downloads Dialog Status
  bool _showDownloadFixDialog;

  set systemThemeAvailable(bool value) {
    _systemThemeAvailable = value;
    if (value)
      _systemThemeEnabled = preferences.getSystemThemeEnabled();
    else
      _systemThemeEnabled = false;
    notifyListeners();
  }

  set accentColor(Color value) {
    _accentColor = value;
    preferences.saveAccentColor(value);
    notifyListeners();
  }

  set systemThemeEnabled(bool value) {
    _systemThemeEnabled = value;
    preferences.saveSystemThemeEnabled(value);
    notifyListeners();
  }

  set darkThemeEnabled(bool value) {
    _darkThemeEnabled = value;
    preferences.saveDarkThemeEnabled(value);
    notifyListeners();
  }

  set blackThemeEnabled(bool value) {
    _blackThemeEnabled = value;
    preferences.saveBlackThemeEnabled(value);
    notifyListeners();
  }

  set enableFFmpegActionType(bool value) {
    _enableFFmpegActionType = value;
    preferences.saveEnableFFmpegActionTypeion(value);
    notifyListeners();
  }

  set enableVideoConvertion(bool value) {
    _enableVideoConvertion = value;
    preferences.saveEnableVideoConvertion(value);
    notifyListeners();
  }

  void loadSavedData() {
    systemThemeAvailable = preferences.isSystemThemeAvailable;
    accentColor = preferences.getAccentColor();
    darkThemeEnabled = preferences.getDarkThemeEnabled();
    blackThemeEnabled = preferences.getBlackThemeEnabled();
    ffmpegActionTypeFormat = preferences.getFFmpegActionTypeingFormat();
    audioDownloadPath = preferences.getAudioDownloadPath();
    videoDownloadPath = preferences.getVideoDownloadPath();
    useBlurBackground = preferences.getBlurBackground();
    useExpandedArtwork = preferences.getExpandedArtwork();
    enableAlbumFolder = preferences.getEnableAlbumFolder();
    _searchHistory =
        (jsonDecode(preferences.getSearchHistory()) as List<dynamic>)
            .cast<String>();
    _channelLogos = ChannelLogo.fromJsonArray(preferences.getChannelLogos());
    // Load Disclaimer Status
    _disclaimerAccepted = preferences.getDisclaimerStatus();
    _showDownloadFixDialog = preferences.getShowDownloadFixDialog();
  }

  // Converting audio format
  set ffmpegActionTypeFormat(String format) {
    _ffmpegActionTypeFormat = format;
    preferences.saveFFmpegActionTypeingFormat(format);
    notifyListeners();
  }

  // Download paths
  set audioDownloadPath(String path) {
    _audioDownloadPath = path;
    preferences.saveAudioDownloadPath(path);
    notifyListeners();
  }

  set videoDownloadPath(String path) {
    _videoDownloadPath = path;
    preferences.saveVideoDownloadPath(path);
    notifyListeners();
  }

  // Album Folder
  set enableAlbumFolder(bool value) {
    _enableAlbumFolder = value;
    preferences.saveEnableAlbumFolder(value);
    notifyListeners();
  }

  // Search History
  List<String> getSearchHistory() => _searchHistory;
  void addStringtoSearchHistory(String searchQuery) {
    if (_searchHistory.contains(searchQuery)) {
      _searchHistory.removeWhere((element) => element == searchQuery);
      _searchHistory.insert(0, searchQuery);
    } else {
      _searchHistory.insert(0, searchQuery);
    }
    preferences.saveSearchHistory(jsonEncode(_searchHistory));
  }

  void removeStringfromSearchHistory(int index) {
    _searchHistory.removeAt(index);
    preferences.saveSearchHistory(jsonEncode(_searchHistory));
    notifyListeners();
  }

  // Navigate ChannelLogo Cache
  List<ChannelLogo> get channelLogos => _channelLogos;
  set channelLogos(List<ChannelLogo> newList) {
    _channelLogos = newList;
    preferences.saveChannelLogos(ChannelLogo.listToJson(newList));
    notifyListeners();
  }

  void addItemtoChannelLogoList(ChannelLogo item) {
    _channelLogos.add(item);
    preferences.saveChannelLogos(ChannelLogo.listToJson(_channelLogos));
  }

  //
  // Settings for the MusicPlayer are found bellow this
  //

  bool _useBlurBackground;
  bool _useExpandedArtwork;

  bool get useBlurBackground => _useBlurBackground;
  set useBlurBackground(bool value) {
    _useBlurBackground = value;
    preferences.saveBlurBackground(value);
    notifyListeners();
  }

  bool get useExpandedArtwork => _useExpandedArtwork;
  set useExpandedArtwork(bool value) {
    _useExpandedArtwork = value;
    preferences.saveExpandedArtwork(value);
    notifyListeners();
  }

  // Disclaimer Status
  bool get disclaimerAccepted => _disclaimerAccepted;
  set disclaimerAccepted(bool value) {
    _disclaimerAccepted = value;
    preferences.saveDisclaimerStatus(value);
    notifyListeners();
  }

  // Show Downloads Fix Dialog
  bool get showDownloadFixDialog => _showDownloadFixDialog;
  set showDownloadFixDialog(bool value) {
    _showDownloadFixDialog = value;
    preferences.saveShowDownloadFixDialog(value);
    notifyListeners();
  }
}
