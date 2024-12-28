import '../../../../exports.dart';
import '../../data/character_data_model.dart';

class HomeCharacterInfoSection extends StatelessWidget {
  final CharacterDataModel characterData;

  const HomeCharacterInfoSection({super.key, required this.characterData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          characterData.name,
          style: getBoldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        5.vs,
        Text(
          characterData.species,
          style: getRegularTextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        5.vs,
        Text(
          characterData.gender,
          style: getRegularTextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
