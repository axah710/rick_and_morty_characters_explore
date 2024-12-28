import 'package:rick_and_morty_characters_explore/features/character_details/data/models/character_details_arguments_model.dart';

import '../../../../exports.dart';
import '../../data/character_data_model.dart';
import 'home_character_info_section.dart';

class HomeCharacterCardSection extends StatelessWidget {
  final CharacterDataModel characterData;

  const HomeCharacterCardSection({super.key, required this.characterData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.5.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.characterDetailRoute,
            arguments: CharacterDetailsArgumentsModel(
              image: characterData.image,
              name: characterData.name,
              gender: characterData.gender,
              species: characterData.species,
              status: characterData.status,
              location: characterData.location,
              origin: characterData.origin,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(7.w, 6.h, 7.w, 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            color: AppColors.lightPurple,
          ),
          child: Row(
            children: [
              CustomImageProviderFromAssetsAndNetwork(
                assetsImagePath: characterData.image,
                assetsImageHeight: 75.h,
                assetsImageWidth: 75.w,
                assetsImageRadius: 14.r,
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: HomeCharacterInfoSection(characterData: characterData),
              ),
              IconButton(
                onPressed: () {
                  //! TODO: Handle favorite action
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
