import 'package:either_dart/either.dart';
import '../../../../core/network/model/response_model.dart';

import '../../../../core/network/abstract/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, BaseResponseModel>> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  });
  Future<Either<Failure, BaseResponseModel>> getCharacterEpisodes(
      List<int> ids);
}
