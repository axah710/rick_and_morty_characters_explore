import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/core/local_storage/constants/app_prefs.dart';
import '../../../../../core/helpers/base_state.dart';
import '../../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../../exports.dart';
import '../../../../home/data/models/response/character_data_response_model.dart';

class FavoritesCubit extends Cubit<CubitStates> {
  FavoritesCubit() : super(LoadingState());

  Future<void> loadFavorites() async {
    try {
      final List<CharacterDataResponseModel> favoriteCharacters =
          await _getFavoriteCharacters();
      emit(LoadedState(data: favoriteCharacters));
    } catch (e) {
      emit(FailedState(message: AppStrings.favoritesFailureMessage));
    }
  }

  Future<void> toggleFavorite(CharacterDataResponseModel character) async {
    try {
      final List<CharacterDataResponseModel> favorites =
          await _getFavoriteCharacters();

      if (favorites.any((item) => item.id == character.id)) {
        favorites.removeWhere((item) => item.id == character.id);
      } else {
        favorites.add(character);
      }

      await _saveFavorites(favorites);
      emit(LoadedState(data: favorites));
    } catch (e) {
      emit(FailedState(message: AppStrings.favoritesFailureMessage));
    }
  }

  Future<List<CharacterDataResponseModel>> _getFavoriteCharacters() async {
    final sharedPref = SharedPreferencesHelper();
    final favoritesJson =
        await sharedPref.getString(AppPrefs.prefsFavoritesKey);
    return favoritesJson.isEmpty
        ? []
        : (json.decode(favoritesJson) as List)
            .map((item) => CharacterDataResponseModel.fromJson(item))
            .toList();
  }

  Future<void> _saveFavorites(
      List<CharacterDataResponseModel> favorites) async {
    final sharedPref = SharedPreferencesHelper();
    await sharedPref.setData(
        AppPrefs.prefsFavoritesKey, json.encode(favorites));
  }

  
}
