//import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:haydikids/core/models/youtube/video.dart';

enum MediaInfoSetType { Video }

class MediaInfoSet {
  //SearchPlaylist playlistFromSearch;
  MediaInfoSetType mediaType;
  Video videoDetails;
  //Playlist playlistDetails;
  //List<Video> playlistVideos;

  String streamManifest;

  List<Video> relatedVideos;
  int autoPlayIndex;

  MediaInfoSet(
      {this.mediaType,
      this.videoDetails,
      this.streamManifest,
      this.relatedVideos}) {
    // playlistVideos = List<Video>();
    relatedVideos = this.relatedVideos ?? List<Video>();
    autoPlayIndex = 0;
  }

  void updateVideoDetails(Video video) {
    videoDetails = video;
    //mediaTags.updateTextControllers(video, video.thumbnailSrc);
  }
}
