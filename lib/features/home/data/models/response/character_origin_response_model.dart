class CharacterOriginResponseModel {
  final String name;
  final String url;

  CharacterOriginResponseModel({required this.name, required this.url});

  factory CharacterOriginResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterOriginResponseModel(
      name: json['name'],
      url: json['url'],
    );
  }
}
