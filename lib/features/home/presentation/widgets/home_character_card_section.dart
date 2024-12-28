import 'package:rick_and_morty_characters_explore/features/character_details/data/models/character_details_arguments_model.dart';

import '../../../../exports.dart';
import '../../data/models/response/character_data_response_model.dart';
import 'home_character_info_section.dart';

class HomeCharacterCardSection extends StatelessWidget {
  final CharacterDataResponseModel characterDataResponseModel;

  const HomeCharacterCardSection(
      {super.key, required this.characterDataResponseModel});

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
              image: characterDataResponseModel.image,
              name: characterDataResponseModel.name,
              gender: characterDataResponseModel.gender,
              species: characterDataResponseModel.species,
              status: characterDataResponseModel.status,
              location: characterDataResponseModel.location.name,
              origin: characterDataResponseModel.origin.name,
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
                assetsImagePath: characterDataResponseModel.image,
                assetsImageHeight: 75.h,
                assetsImageWidth: 75.w,
                assetsImageRadius: 14.r,
                isNetworkImage: true,
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: HomeCharacterInfoSection(
                    characterDataResponseModel: characterDataResponseModel),
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
