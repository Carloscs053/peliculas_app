// En lib/models/actor_details_response.dart
import 'dart:convert';

class ActorDetailsResponse {
  final String? biography;
  final String? birthday;
  final String? deathday;
  final int id;
  final String name;
  final String? placeOfBirth;
  final String? profilePath;

  ActorDetailsResponse({
    this.biography,
    this.birthday,
    this.deathday,
    required this.id,
    required this.name,
    this.placeOfBirth,
    this.profilePath,
  });

  factory ActorDetailsResponse.fromRawJson(String str) =>
      ActorDetailsResponse.fromJson(json.decode(str));

  factory ActorDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) => ActorDetailsResponse(
    // Si la biografía viene vacía desde TMDB, la capturamos como null para manejarla mejor
    biography: json["biography"] == "" ? null : json["biography"],
    birthday: json["birthday"],
    deathday: json["deathday"],
    id: json["id"],
    name: json["name"],
    placeOfBirth: json["place_of_birth"],
    profilePath: json["profile_path"],
  );
}
