class CharacterInfoResponseModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharacterInfoResponseModel(
      {required this.count, required this.pages, this.next, this.prev});

  factory CharacterInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterInfoResponseModel(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}