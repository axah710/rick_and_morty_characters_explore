import '../../../../exports.dart';
import '../../data/models/character_details_arguments_model.dart';
import 'build_character_attribute_section.dart';

Widget buildCharacterDetailsContainer(
  CharacterDetailsArgumentsModel characterDetails,
) {
  return Container(
    width: double.infinity,
    padding: 16.all,
    decoration: BoxDecoration(
      color: AppColors.lightPurple,
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Column(
      children: [
        50.vs,
        CustomImageProviderFromAssetsAndNetwork(
          assetsImagePath: characterDetails.image,
          assetsImageHeight: 150.h,
          assetsImageWidth: 250.w,
          assetsImageRadius: 14.r,
          isNetworkImage: true,
        ),
        8.vs,
        Text(
          characterDetails.name,
          style: getBoldTextStyle(color: AppColors.white, fontSize: 36),
        ),
        8.vs,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCharacterAttribute("Species", characterDetails.species),
            buildCharacterAttribute("Gender", characterDetails.gender),
            buildCharacterAttribute("Status", characterDetails.status),
            buildCharacterAttribute("Origin", characterDetails.origin),
            buildCharacterAttribute("Location", characterDetails.location),
          ],
        ).alignCenterStart()
      ],
    ),
  );
}
