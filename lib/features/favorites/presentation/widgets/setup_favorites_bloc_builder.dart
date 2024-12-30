import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/base_state.dart';
import '../../../../exports.dart';
import '../../../home/data/models/characters/response/character_data_response_model.dart';
import '../managers/cubit/favorites_cubit.dart';
import 'favorites_body_section.dart';

class SetupFavoritesBlocBuilder extends StatelessWidget {
  const SetupFavoritesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, CubitStates>(
      buildWhen: (previous, current) =>
          current is LoadedState || current is FailedState,
      builder: (context, state) {
        if (state is LoadedState) {
          return setupSuccess(state.data);
        } else if (state is FailedState) {
          return setupError();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget setupSuccess(List<CharacterDataResponseModel> favoriteCharacters) {
    return FavoritesBodySection(favoriteCharacters: favoriteCharacters);
  }

  Widget setupError() {
    return Center(
      child: Text(
        'Failed to load favorites',
        style: getSemiBoldTextStyle(fontSize: 24, color: AppColors.white),
      ),
    );
  }
}
