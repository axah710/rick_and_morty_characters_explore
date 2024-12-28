import '../../../../exports.dart';
import '../../data/models/response/character_data_response_model.dart';

class HomeCharacterInfoSection extends StatelessWidget {
  final CharacterDataResponseModel characterDataResponseModel;

  const HomeCharacterInfoSection({super.key, required this.characterDataResponseModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          characterDataResponseModel.name,
          style: getBoldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        5.vs,
        Text(
          characterDataResponseModel.species,
          style: getRegularTextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
        5.vs,
        Text(
          characterDataResponseModel.gender,
          style: getRegularTextStyle(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
