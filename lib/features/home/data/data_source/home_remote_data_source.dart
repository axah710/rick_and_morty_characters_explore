import 'package:rick_and_morty_characters_explore/core/network/impl/dio_impl/dio_consumer.dart';
import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';
import 'package:rick_and_morty_characters_explore/features/home/data/models/response/character_response_model.dart';
import '../../../../core/helpers/app_helper.dart';
import '../../../../core/network/constants/endpoinst.dart';
import '../../../../core/utils/debug_prints.dart';

abstract class HomeRemoteDataSource {
  Future<BaseResponseModel> getAllCharacters({int page = 1});
}

class CharactersRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioConsumer dioConsumer;

  CharactersRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<BaseResponseModel> getAllCharacters({int page = 1}) async {
    return await remoteExecute(
      request: dioConsumer.getRequest(
        path: EndPoints.charactersEndPoint,
        queryParams: {
          "page": page,
        },
      ).then((response) {
        Logger.printInfo(
            "Characters Raw Response: ${response.data.toString()}");
        return response;
      }),
      fromJsonFunction: (data) => CharacterResponseModel.fromJson(data),
    );
  }
}
