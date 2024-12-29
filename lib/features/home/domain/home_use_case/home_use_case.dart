import 'package:either_dart/either.dart';
import '../../../../core/network/model/response_model.dart';

import '../../../../core/network/abstract/failure.dart';
import '../home_repo/home_repo.dart';

class HomeUseCase {
  final HomeRepository repository;

  HomeUseCase({required this.repository});

  Future<Either<Failure, BaseResponseModel>> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  }) {
    return repository.getAllCharacters(
      page: page,
      name: name,
      status: status,
      species: species,
    );
  }
}
