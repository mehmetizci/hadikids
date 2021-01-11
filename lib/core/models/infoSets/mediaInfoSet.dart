//import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:haydikids/core/models/youtube/video.dart';

enum MediaInfoSetType { Video, Playlist }

class MediaInfoSet {
  SearchVideo videoFromSearch;
  SearchPlaylist playlistFromSearch;
  MediaInfoSetType mediaType;
  Video videoDetails;
  Playlist playlistDetails;
  List<Video> playlistVideos;
  Channel channelDetails;
  StreamManifest streamManifest;

  List<Video> relatedVideos;
  int autoPlayIndex;

  MediaInfoSet(
      {this.videoFromSearch,
      this.playlistFromSearch,
      this.mediaType,
      this.videoDetails,
      this.playlistDetails,
      this.streamManifest,
      this.channelDetails,
      this.relatedVideos}) {
    playlistVideos = List<Video>();
    relatedVideos = this.relatedVideos ?? List<Video>();
    autoPlayIndex = 0;
  }

  void updateVideoDetails(Video video) {
    videoDetails = video;
    mediaTags.updateTextControllers(video, video.thumbnailSrc);
  }

  void updatePlaylistDetails(Playlist playlist) {
    playlistDetails = playlist;
    mediaTags.updateTextControllersFromPlaylist(
        playlist, playlist.thumbnails.maxResUrl);
  }
}
