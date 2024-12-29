import 'character_location_response_model.dart';
import 'character_origin_response_model.dart';

class CharacterDataResponseModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterOriginResponseModel origin;
  final CharacterLocationResponseModel location;
  final String image;

  CharacterDataResponseModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory CharacterDataResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterDataResponseModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: CharacterOriginResponseModel.fromJson(json['origin']),
      location: CharacterLocationResponseModel.fromJson(json['location']),
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
    };
  }
}
