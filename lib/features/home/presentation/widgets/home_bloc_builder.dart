import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/response/character_data_response_model.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_screen_body_section.dart';
import '../../../../core/helpers/base_state.dart';
import '../../../../exports.dart';
import 'home_characters_paginated_list_section.dart';

class SetupCharactersBlocBuilder extends StatelessWidget {
  const SetupCharactersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, CubitStates>(
      buildWhen: (previous, current) =>
          current is LoadedState || current is FailedState,
      builder: (context, state) {
        if (state is LoadedState) {
          return setupSuccess(state.data);
        }
        if (state is FailedState) {
          return setupError();
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

  Widget setupError() {
    return Center(
      child: Text(
        AppStrings.errorOccurred,
        style: getRegularTextStyle(color: AppColors.white, fontSize: 16),
      ),
    );
  }
}
