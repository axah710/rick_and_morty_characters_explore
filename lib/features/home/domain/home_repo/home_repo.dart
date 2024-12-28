import 'package:either_dart/either.dart';
import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';

import '../../../../core/network/abstract/failure.dart';

abstract class CharacterRepository {
  Future<Either<Failure, BaseResponseModel>> getAllCharacters({int page = 1});
}
