import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/response/character_response_model.dart';

import '../../../../../core/helpers/app_helper.dart';
import '../../../../../core/helpers/base_state.dart';
import '../../../../../core/utils/debug_prints.dart';
import '../../../../../exports.dart';
import '../../../data/models/response/character_data_response_model.dart';
import '../../../domain/home_use_case/home_use_case.dart';

class HomeCubit extends Cubit<CubitStates> {
  final HomeUseCase getAllCharactersUseCase;
  final PagingController<int, CharacterDataResponseModel> pagingController =
      PagingController(firstPageKey: 1);

  String? searchQuery;
  String? statusFilter;
  String? speciesFilter;

  HomeCubit({required this.getAllCharactersUseCase}) : super(LoadingState()) {
    pagingController.addPageRequestListener((pageKey) {
      fetchCharacters(page: pageKey);
    });
  }

  void updateSearchAndFilters({
    String? query,
    String? status,
    String? species,
  }) {
    searchQuery = query;
    statusFilter = status;
    speciesFilter = species;

    // Reset paging
    pagingController.refresh();
  }

  Future<void> fetchCharacters({int page = 1}) async {
    await managerExecute(
      getAllCharactersUseCase.getAllCharacters(
        page: page,
        name: searchQuery,
        status: statusFilter,
        species: speciesFilter,
      ),
      onStart: () {
        Logger.printInfo('Fetching characters...');
      },
      onSuccess: (data) {
        final characters = (data as CharacterResponseModel).data ??
            <CharacterDataResponseModel>[];
        final isLastPage = characters.length < AppConstants.pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(characters);
        } else {
          final nextPageKey = page + 1;
          pagingController.appendPage(characters, nextPageKey);
        }
        emit(LoadedState(data: characters));
      },
      onFail: (message) {
        Logger.printError('Failed to fetch characters: $message');
        pagingController.error = message;
        emit(FailedState(message: message));
      },
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
