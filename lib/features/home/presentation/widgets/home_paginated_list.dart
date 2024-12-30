import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../exports.dart';
import '../../data/models/characters/response/character_data_response_model.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_character_card_section.dart';

class HomePaginatedListSection extends StatelessWidget {
  final HomeCubit cubit;
  const HomePaginatedListSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagedListView<int, CharacterDataResponseModel>(
        pagingController: cubit.pagingController,
        builderDelegate: PagedChildBuilderDelegate<CharacterDataResponseModel>(
          itemBuilder: (context, character, index) => HomeCharacterCardSection(
            characterDataResponseModel: character,
          ),
        ),
      ),
    );
  }
}
