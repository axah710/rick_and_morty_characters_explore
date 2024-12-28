import 'package:either_dart/either.dart';
import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';
import 'package:rick_and_morty_characters_explore/features/home/domain/home_repo/home_repo.dart';

import '../../../../core/helpers/app_helper.dart';
import '../../../../core/network/abstract/failure.dart';
import '../../../../core/utils/debug_prints.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BaseResponseModel>> getAllCharacters({int page = 1}) {
    return execute(
      () async {
        Logger.printInfo("Calling Get All Characters remote data source...");
        return remoteDataSource.getAllCharacters(page: page);
      },
    );
  }
}
