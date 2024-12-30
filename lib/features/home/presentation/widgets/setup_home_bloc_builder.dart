import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../core/helpers/base_state.dart';
import '../../../../core/network/app_service.dart';
import '../../../../exports.dart';
import '../../data/models/characters/response/character_data_response_model.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_screen_body_section.dart';

class SetupCharactersBlocBuilder extends StatelessWidget {
  const SetupCharactersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, CubitStates>(
      buildWhen: (previous, current) =>
          current is LoadedState &&
              current.data is List<CharacterDataResponseModel> ||
          current is FailedState,
      builder: (context, state) {
        if (state is LoadedState) {
          context.read<HomeCubit>().getEpisodeIdsFromCharacter(state.data);
          return setupSuccess(state.data);
        }
        if (state is FailedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setupError(context, state.message);
          });
          return setupLoading();
        }
        if (state is LoadingState) {
          return setupLoading();
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
      List<CharacterDataResponseModel> characterDataResponseModel) {
    return HomeScreenBodySection();
  }

  Widget setupError(BuildContext context, String message) {
    AppService().showCustomDialogWithTimer(
      message: message,
      dialogType: AlertTypes.error,
      onTimeOut: () => Routes.homeRoute.pushAndRemoveAllUntil(),
    );
    return const SizedBox.shrink();
  }
}
