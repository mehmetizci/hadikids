import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String url;
  final String duration;
  final String snippet;
  final String uploadDate;
  final String thumbnailSrc;
  final String views;
  final String username;
  final String channelUrl;
  final bool verified;

  Video(
      {this.id,
      this.title,
      this.url,
      this.duration,
      this.snippet,
      this.uploadDate,
      this.thumbnailSrc,
      this.views,
      this.username,
      this.channelUrl,
      this.verified});

  static Video fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final url = json['url'];
    final duration = json['duration'];
    final snippet = json['snippet'];
    final uploadDate = json['upload_date'];
    final thumbnailSrc = json['thumbnail_src'];
    final views = json['views'];
    final username = json['username'];
    final channelUrl = json['channel_url'];
    final verified = json['verified'];

    return Video(
      id: id,
      title: title,
      url: url,
      duration: duration,
      snippet: snippet,
      uploadDate: uploadDate,
      thumbnailSrc: thumbnailSrc,
      views: views,
      username: username,
      channelUrl: channelUrl,
      verified: verified,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "duration": duration == null ? null : duration,
        "snippet": snippet == null ? null : snippet,
        "upload_date": uploadDate == null ? null : uploadDate,
        "thumbnail_src": thumbnailSrc == null ? null : thumbnailSrc,
        "views": views == null ? null : views,
        "username": username == null ? null : username,
        "channel_url": channelUrl == null ? null : channelUrl,
        "verified": verified == null ? null : verified,
      };

  @override
  List<Object> get props => [
        id,
        title,
        url,
        duration,
        snippet,
        uploadDate,
        thumbnailSrc,
        views,
        username,
        channelUrl,
        verified,
      ];
}
