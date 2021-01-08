// Internal
import 'package:haydikids/core/models/videoFile.dart';

class FolderItem {
  String name;
  String path;
  List<VideoFile> videos;

  FolderItem({
    this.name,
    this.path,
  }) {
    videos = new List<VideoFile>();
  }
}
