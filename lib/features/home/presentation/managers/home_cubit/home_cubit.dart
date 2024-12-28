import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/features/home/data/models/response/character_response_model.dart';

import '../../../../../core/helpers/app_helper.dart';
import '../../../../../core/helpers/base_state.dart';
import '../../../../../core/utils/debug_prints.dart';
import '../../../domain/home_use_case/home_use_case.dart';

class CharacterCubit extends Cubit<CubitStates> {
  final GetAllCharactersUseCase getAllCharactersUseCase;
  CharacterResponseModel? characterDataResponseModel;

  CharacterCubit({required this.getAllCharactersUseCase})
      : super(LoadingState());

  fetchCharacters({int page = 1}) async {
    Logger.printDone('Character Cubit created!');
    managerExecute(
      getAllCharactersUseCase.getAllCharacters(page: page),
      onSuccess: (data) async {
        characterDataResponseModel = data as CharacterResponseModel?;
        Logger.printDone(
            "Character Data response: ${characterDataResponseModel.toString()}");
        emit(LoadedState(data: characterDataResponseModel));
      },
    );
  }
}
