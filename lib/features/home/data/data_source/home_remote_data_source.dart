import '../../../../core/helpers/app_helper.dart';
import '../../../../core/network/constants/endpoinst.dart';
import '../../../../core/network/impl/dio_impl/dio_consumer.dart';
import '../../../../core/network/model/response_model.dart';
import '../../../../core/utils/debug_prints.dart';
import '../models/characters/response/character_response_model.dart';
import '../models/episodes/response/episodes_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<BaseResponseModel> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  });
  Future<BaseResponseModel> getCharacterEpisodes(List<int> ids);
}

class CharactersRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioConsumer dioConsumer;

  CharactersRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<BaseResponseModel> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  }) async {
    final queryParams = _buildQueryParams(page, name, status, species);

    return remoteExecute(
      request: dioConsumer
          .getRequest(
        path: EndPoints.charactersEndPoint,
        queryParams: queryParams,
      )
          .then((response) {
        Logger.printInfo("Characters Raw Response: ${response.data}");
        return response;
      }),
      fromJsonFunction: (data) => CharacterResponseModel.fromJson(data),
    );
  }

  @override
  Future<BaseResponseModel> getCharacterEpisodes(List<int> ids) async {
    final queryParams = {"ids": ids.join(",")};
    return remoteExecute(
      request: dioConsumer
          .getRequest(
        path: EndPoints.episodesEndPoint,
        queryParams: queryParams,
      )
          .then((response) {
        Logger.printInfo("Episodes Raw Response: ${response.data}");
        return response;
      }),
      fromJsonFunction: (data) => EpisodesResponseModel.fromJson(data),
    );
  }

  Map<String, dynamic> _buildQueryParams(
      int page, String? name, String? status, String? species) {
    final params = {
      "page": page,
      "name": name,
      "status": status,
      "species": species,
    };
    //! Remove null or empty values
    params.removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
    return params;
  }
}
