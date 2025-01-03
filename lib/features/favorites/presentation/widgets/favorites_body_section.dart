import '../../../../core/widgets/logo_app_bar_widget.dart';
import '../../../../exports.dart';
import '../../../home/data/models/characters/response/character_data_response_model.dart';
import '../../../home/presentation/widgets/home_character_card_section.dart';
import 'build_empty_favorites.dart';

class FavoritesBodySection extends StatelessWidget {
  final List<CharacterDataResponseModel> favoriteCharacters;

  const FavoritesBodySection({super.key, required this.favoriteCharacters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoAppBarWidget(isPop: true),
        25.vs,
        CustomImageProviderFromAssetsAndNetwork(
          assetsImagePath: AppAssets.favorites,
          assetsImageHeight: 100.0,
        ),
        25.vs,
        Expanded(
          child: favoriteCharacters.isEmpty
              ? buildEmptyFavorites()
              : ListView.builder(
                  itemCount: favoriteCharacters.length,
                  itemBuilder: (context, index) {
                    final character = favoriteCharacters[index];
                    return HomeCharacterCardSection(
                      characterDataResponseModel: character,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
