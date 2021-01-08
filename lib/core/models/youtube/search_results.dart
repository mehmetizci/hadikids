import 'package:equatable/equatable.dart';
import 'package:haydikids/core/models/youtube/search_result_item.dart';

class YoutubeSearchResult extends Equatable {
  final List<Results> results;
  final String version;
  final String parser;
  final String key;
  final String estimatedResults;
  final String nextPageToken;

  YoutubeSearchResult(
      {this.results,
      this.version,
      this.parser,
      this.key,
      this.estimatedResults,
      this.nextPageToken});

  static YoutubeSearchResult fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>)
        .map((dynamic item) => Results.fromJson(item as Map<String, dynamic>))
        .toList();
    final key = json['key'];
    final nextPageToken = json['nextPageToken'];
    return YoutubeSearchResult(
        results: results, key: key, nextPageToken: nextPageToken);
  }

  @override
  List<Object> get props => [
        results,
        version,
        parser,
        key,
        estimatedResults,
        nextPageToken,
      ];
}
