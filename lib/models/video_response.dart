import 'dart:convert';

class VideoResponse {
  final List<Video> results;

  VideoResponse({required this.results});

  factory VideoResponse.fromRawJson(String str) =>
      VideoResponse.fromJson(json.decode(str));

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
    results: List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
  );
}

class Video {
  final String key;
  final String name;
  final String site;
  final String type;

  Video({
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    key: json["key"],
    name: json["name"],
    site: json["site"],
    type: json["type"],
  );
}
