import '../../../../core/network/constants/endpoinst.dart';
import '../../../../core/network/impl/dio_impl/dio_consumer.dart';
import '../../../../core/network/model/response_model.dart';
import '../models/response/character_response_model.dart';
import '../../../../core/helpers/app_helper.dart';
import '../../../../core/utils/debug_prints.dart';

abstract class HomeRemoteDataSource {
  Future<BaseResponseModel> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  });
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
