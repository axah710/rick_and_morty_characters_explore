import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/features/home/presentation/managers/home_cubit/home_cubit.dart';
import 'package:rick_and_morty_characters_explore/features/home/presentation/widgets/home_screen_body_section.dart';
import '../../../../core/helpers/base_state.dart';
import '../../../../exports.dart';
import '../../data/models/response/character_response_model.dart';

class SetupCharactersBlocBuilder extends StatelessWidget {
  const SetupCharactersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CubitStates>(
      buildWhen: (previous, current) =>
          current is LoadedState || current is FailedState,
      builder: (context, state) {
        // if (state is LoadingState) {
        //   return setupLoading();
        // }
        if (state is LoadedState) {
          return setupSuccess(state.data);
        } else if (state is FailedState) {
          return setupError();
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Widget setupLoading() {
  //   return const Center(
  //     child: CircularProgressIndicator(),
  //   );
  // }

  Widget setupSuccess(CharacterResponseModel characterDataResponseModel) {
    return HomeScreenBodySection();
  }

  Widget setupError() {
    return const Center(
      child: Text('An error occurred. Please try again.'),
    );
  }
}
