import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/base_state.dart';

import '../../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../../exports.dart';
import '../../../../home/data/models/response/character_data_response_model.dart';

class FavoritesCubit extends Cubit<CubitStates> {
  FavoritesCubit() : super(LoadingState());

  Future<void> loadFavorites() async {
    try {
      final sharedPref = SharedPreferencesHelper();
      final favoritesJson = await sharedPref.getString('favorites');
      final favoriteCharacters = favoritesJson.isEmpty
          ? []
          : (json.decode(favoritesJson) as List)
              .map((item) => CharacterDataResponseModel.fromJson(item))
              .toList();
      emit(LoadedState(data: favoriteCharacters));
    } catch (e) {
      emit(FailedState(message: "Failed to load favorites"));
    }
  }

  Future<void> toggleFavorite(CharacterDataResponseModel character) async {
    final sharedPref = SharedPreferencesHelper();
    final favoritesJson = await sharedPref.getString('favorites');
    List<CharacterDataResponseModel> favorites = favoritesJson.isEmpty
        ? []
        : (json.decode(favoritesJson) as List)
            .map((item) => CharacterDataResponseModel.fromJson(item))
            .toList();

    if (favorites.any((item) => item.id == character.id)) {
      favorites.removeWhere((item) => item.id == character.id);
    } else {
      favorites.add(character);
    }

    await sharedPref.setData('favorites', json.encode(favorites));
    loadFavorites(); //! Reload favorites to update the UI
  }
}

