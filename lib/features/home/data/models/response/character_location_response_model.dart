class CharacterLocationResponseModel {
  final String name;
  final String url;

  CharacterLocationResponseModel({required this.name, required this.url});

  factory CharacterLocationResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterLocationResponseModel(
      name: json['name'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
