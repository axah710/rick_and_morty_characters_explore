import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/core/network/model/response_model.dart';
import 'package:rick_and_morty_characters_explore/features/home/data/models/episodes/response/episodes_data_response_model.dart';
import 'package:rick_and_morty_characters_explore/features/home/data/models/episodes/response/episodes_response_model.dart';

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
    return ListView.builder(
      itemCount: episodesDataResponseModel.length,
      padding: 15.ph + 10.pv,
      itemBuilder: (context, index) {
        final episode = episodesDataResponseModel[index];
        return Card(
          margin: EdgeInsets.only(bottom: 10.0.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0.r),
              border: Border.all(color: AppColors.lightPurple, width: 1.5.w),
            ),
            padding: 12.all,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightPurple,
                  child: Text(
                    episode.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                12.hs,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        episode.name,
                        style: getBoldTextStyle(
                          color: AppColors.lightPurple,
                          fontSize: 16.0,
                        ),
                      ),
                      4.vs,
                      Text(
                        'Episode ${index + 1}',
                        style: getRegularTextStyle(
                          color: AppColors.lightPurple,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget setupError(BuildContext context, String message) {
    return Text(message);
  }
}
