import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/episodes/response/episodes_data_response_model.dart';

import '../../../../../core/helpers/app_helper.dart';
import '../../../../../core/helpers/base_state.dart';
import '../../../../../core/utils/debug_prints.dart';
import '../../../../../exports.dart';
import '../../../data/models/characters/response/character_data_response_model.dart';
import '../../../data/models/characters/response/character_response_model.dart';
import '../../../domain/home_use_case/home_use_case.dart';

class HomeCubit extends Cubit<CubitStates> {
  final HomeUseCase homeUseCase;
  List<EpisodesDataResponseModel>? episodesDataResponseModel;
  final PagingController<int, CharacterDataResponseModel> pagingController =
      PagingController(firstPageKey: 1);
  String? searchQuery;
  String? statusFilter;
  String? speciesFilter;
  Timer? _debounce;

  HomeCubit({required this.homeUseCase}) : super(LoadingState()) {
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

    //! Debounce the fetchCharacters call
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      //! Reset paging
      pagingController.refresh();
    });
  }

  Future<void> fetchCharacters({int page = 1}) async {
    await managerExecute(
      homeUseCase.getAllCharacters(
        page: page,
        name: searchQuery,
        status: statusFilter,
        species: speciesFilter,
      ),
      onStart: _onFetchStart,
      onSuccess: (data) =>
          _onFetchSuccess(data as CharacterResponseModel, page),
      onFail: _onFetchFail,
    );
  }

  void _onFetchStart() {
    Logger.printInfo('Fetching characters...');
  }

  void _onFetchSuccess(CharacterResponseModel data, int page) {
    final characters = data.data ?? <CharacterDataResponseModel>[];
    final isLastPage = characters.length < AppConstants.pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(characters);
    } else {
      final nextPageKey = page + 1;
      pagingController.appendPage(characters, nextPageKey);
    }
    emit(LoadedState(data: characters));
  }

  void _onFetchFail(String message) {
    Logger.printError('Failed to fetch characters: $message');
    pagingController.error =
        message; //! Display the error in the PagingController
    emit(
      FailedState(message: message),
    );
  }

  fetchEpisodes(List<int> ids) async {
    await managerExecute(
      homeUseCase.getCharacterEpisodes(ids),
      onSuccess: (data) {
        episodesDataResponseModel = data?.data;
        emit(
          LoadedState(data: episodesDataResponseModel),
        );
      },
      onFail: (message) => emit(
        FailedState(message: message),
      ),
      onStart: () => Logger.printInfo('Fetching episodes...'),
    );
  }

  void getEpisodeIdsFromCharacter(
      List<CharacterDataResponseModel> characterData) async {
    final episodeUrls = characterData
        .map((character) => character.episode)
        .expand((episodes) => episodes)
        .toList();
    final episodeIds = episodeUrls
        .map((url) {
          final regex = RegExp(r'\/(\d+)$');
          final match = regex.firstMatch(url);
          return match != null ? int.parse(match.group(1)!) : null;
        })
        .where((id) => id != null)
        .cast<int>()
        .toList();
    await fetchEpisodes(episodeIds);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    pagingController.dispose();
    return super.close();
  }
}
