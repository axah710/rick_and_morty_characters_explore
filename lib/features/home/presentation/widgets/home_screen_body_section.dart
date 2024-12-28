import 'package:rick_and_morty_characters_explore/features/home/presentation/widgets/home_characters_list_section.dart';
import 'package:rick_and_morty_characters_explore/features/home/presentation/widgets/home_favorite_text_section.dart';

import '../../../../exports.dart';
import 'home_search_field_section.dart';

class HomeScreenBodySection extends StatelessWidget {
  const HomeScreenBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarWithBackArrowSection(
          isPop: false,
          appBarTitle: AppStrings.findYourCharacter,
        ),
        35.5.vs,
        HomeSearchFieldSection(),
        12.5.vs,
        HomeFavoriteTextSection(),
        17.5.vs,
        Expanded(
          child: HomeCharactersListSection(),
        ),
      ],
    );
  }
}
