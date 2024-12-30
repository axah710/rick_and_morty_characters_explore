class EpisodesDataResponseModel {
  final int id;
  final String name;
  final String airDate;
  final String episodeCode;
  final List<String> characters;

  EpisodesDataResponseModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.characters,
  });

  factory EpisodesDataResponseModel.fromJson(Map<String, dynamic> json) {
    return EpisodesDataResponseModel(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episodeCode: json['episode'],
      characters: List<String>.from(json['characters']),
    );
  }
}
