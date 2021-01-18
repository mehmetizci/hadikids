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
  final String channelUrl;
  final String channelLogo;

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
      this.channelUrl,
      this.channelLogo});

  static Video fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final url = json['url'];
    final duration = json['duration'];
    final snippet = json['snippet'];
    final uploadDate = json['upload_date'];
    final thumbnailUrl = json['thumbnailUrl'];
    final views = json['views'];
    final channelName = json['channelName'];
    final channelId = json['channelId'];
    final channelUrl = json['channel_url'];
    final channelLogo = json['channelLogo'];

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
      channelUrl: channelUrl,
      channelLogo: channelLogo,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "duration": duration == null ? null : duration,
        "snippet": snippet == null ? null : snippet,
        "upload_date": uploadDate == null ? null : uploadDate,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "views": views == null ? null : views,
        "channelName": channelName == null ? null : channelName,
        "channelId": channelId == null ? null : channelId,
        "channel_url": channelUrl == null ? null : channelUrl,
        "channelLogo": channelLogo == null ? null : channelLogo,
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
        channelId,
        channelUrl,
        channelLogo,
      ];
}
