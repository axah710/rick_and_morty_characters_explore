import '../../../../../core/network/model/response_model.dart';
import 'character_data_response_model.dart';
import 'character_info_response_model.dart';

class CharacterResponseModel extends BaseResponseModel {
  final CharacterInfoResponseModel info;

  CharacterResponseModel({required this.info, required super.data});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: CharacterInfoResponseModel.fromJson(json['info']),
      data: (json['results'] as List)
          .map((character) => CharacterDataResponseModel.fromJson(character))
          .toList(),
    );
  }
}
