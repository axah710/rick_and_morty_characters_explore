import '../../../../core/network/impl/dio_impl/dio_consumer.dart';
import '../../../../core/network/model/response_model.dart';
import '../models/response/character_response_model.dart';
import '../../../../core/helpers/app_helper.dart';
import '../../../../core/network/constants/endpoinst.dart';
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
    String? name, // Search query
    String? status, // Filter: status
    String? species, // Filter: species
  }) async {
    return await remoteExecute(
      request: dioConsumer.getRequest(
        path: EndPoints.charactersEndPoint,
        queryParams: {
          "page": page,
          if (name != null && name.isNotEmpty) "name": name,
          if (status != null && status.isNotEmpty) "status": status,
          if (species != null && species.isNotEmpty) "species": species,
        },
      ).then((response) {
        Logger.printInfo("Characters Raw Response: ${response.data}");
        return response;
      }),
      fromJsonFunction: (data) => CharacterResponseModel.fromJson(data),
    );
  }
}
