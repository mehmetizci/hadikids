import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String url;
  final String duration;
  final String snippet;
  final String uploadDate;
  final String thumbnailUrl;
  final String views;
  final String channelName;
  final String channelId;
  final String channelLogo;
  final String channelUrl;
  final String likeCount;
  final String dislikeCount;

  Video(
      {this.id,
      this.title,
      this.url,
      this.duration,
      this.snippet,
      this.uploadDate,
      this.thumbnailUrl,
      this.views,
      this.channelName,
      this.channelId,
      this.channelLogo,
      this.channelUrl,
      this.likeCount,
      this.dislikeCount});

  static Video fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final url = json['url'];
    final duration = json['duration'];
    final snippet = json['snippet'];
    final uploadDate = json['uploadDate'];
    final thumbnailUrl = json['thumbnailUrl'];
    final views = json['views'];
    final channelName = json['channelName'];
    final channelId = json['channelId'];
    final channelLogo = json['channelLogo'];
    final channelUrl = json['channelUrl'];
    final likeCount = json['likeCount'] ?? "0";
    final dislikeCount = json['dislikeCount'] ?? "0";

    return Video(
      id: id,
      title: title,
      url: url,
      duration: duration,
      snippet: snippet,
      uploadDate: uploadDate,
      thumbnailUrl: thumbnailUrl,
      views: views,
      channelName: channelName,
      channelId: channelId,
      channelLogo: channelLogo,
      channelUrl: channelUrl,
      likeCount: likeCount,
      dislikeCount: dislikeCount,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "duration": duration == null ? null : duration,
        "snippet": snippet == null ? null : snippet,
        "uploadDate": uploadDate == null ? null : uploadDate,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "views": views == null ? null : views,
        "channelName": channelName == null ? null : channelName,
        "channelUrl": channelUrl == null ? null : channelUrl,
        "channelId": channelId == null ? null : channelId,
        "channelLogo": channelLogo == null ? null : channelLogo,
        "likeCount": likeCount == null ? null : likeCount,
        "dislikeCount": dislikeCount == null ? null : dislikeCount,
      };

  @override
  List<Object> get props => [
        id,
        title,
        url,
        duration,
        snippet,
        uploadDate,
        thumbnailUrl,
        views,
        channelName,
        channelUrl,
        channelId,
        channelLogo,
        channelUrl,
        likeCount,
        dislikeCount,
      ];
}
