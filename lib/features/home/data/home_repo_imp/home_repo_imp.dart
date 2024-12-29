import 'package:either_dart/either.dart';
import '../../../../core/network/model/response_model.dart';
import '../../domain/home_repo/home_repo.dart';

import '../../../../core/helpers/app_helper.dart';
import '../../../../core/network/abstract/failure.dart';
import '../../../../core/utils/debug_prints.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BaseResponseModel>> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
  }) {
    return execute(
      () async {
        Logger.printInfo("Fetching characters with filters...");
        return remoteDataSource.getAllCharacters(
          page: page,
          name: name,
          status: status,
          species: species,
        );
      },
    );
  }
}
