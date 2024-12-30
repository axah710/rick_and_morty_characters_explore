import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';

import 'episodes_data_response_model.dart';

class EpisodesResponseModel extends BaseResponseModel {
  EpisodesResponseModel({required super.data});

  factory EpisodesResponseModel.fromJson(Map<String, dynamic> json) {
    return EpisodesResponseModel(
      data: (json['results'] as List)
          .map((episode) => EpisodesDataResponseModel.fromJson(episode))
          .toList(),
    );
  }
}
