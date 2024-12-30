class CharacterDetailsArgumentsModel {
  final String image;
  final String name;
  final String gender;
  final String species;
  final String status;
  final String origin;
  final String location;
  final List episodes;

  CharacterDetailsArgumentsModel({
    required this.episodes,
    required this.status,
    required this.origin,
    required this.location,
    required this.image,
    required this.name,
    required this.gender,
    required this.species,
  });
}
