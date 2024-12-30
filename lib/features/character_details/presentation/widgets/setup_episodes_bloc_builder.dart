import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/features/character_details/presentation/widgets/character_episodes_names_list_section.dart';
import '../../../home/data/models/episodes/response/episodes_data_response_model.dart';

import '../../../../core/helpers/base_state.dart';
import '../../../../exports.dart';
import '../../../home/presentation/managers/home_cubit/home_cubit.dart';

class SetupEpisodesBlocBuilder extends StatelessWidget {
  const SetupEpisodesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, CubitStates>(
      buildWhen: (previous, current) =>
          current is LoadedState &&
              current.data is List<EpisodesDataResponseModel> ||
          current is FailedState,
      builder: (context, state) {
        if (state is LoadedState) {
          return setupSuccess(state.data);
        } else if (state is FailedState) {
          return setupError(context, state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget setupLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.white,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
      ),
    );
  }

  Widget setupSuccess(
      List<EpisodesDataResponseModel> episodesDataResponseModel) {
    return CharacterEpisodesNamesListSection(
      episodesDataResponseModel: episodesDataResponseModel,
    );
  }

  Widget setupError(BuildContext context, String message) {
    return Text(message);
  }
}
