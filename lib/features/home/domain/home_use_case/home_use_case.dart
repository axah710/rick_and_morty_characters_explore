import 'package:either_dart/either.dart';
import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';

import '../../../../core/network/abstract/failure.dart';
import '../home_repo/home_repo.dart';

class GetAllCharactersUseCase {
  final CharacterRepository repository;

  GetAllCharactersUseCase({required this.repository});

  Future<Either<Failure, BaseResponseModel>> getAllCharacters({int page = 1}) {
    return repository.getAllCharacters(page: page);
  }
}
