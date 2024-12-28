import '../../../../exports.dart';
import '../../data/models/response/character_data_response_model.dart';
import 'character_data_model_dummy_data.dart';
import 'home_character_card_section.dart';

class HomeCharactersListSection extends StatelessWidget {
  final List<CharacterDataResponseModel> characterDataResponseModel;
  const HomeCharactersListSection(
      {super.key, required this.characterDataResponseModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: characterDataList.length,
        itemBuilder: (context, index) {
          return HomeCharacterCardSection(
            characterDataResponseModel: characterDataResponseModel[index],
          );
        },
      ),
    );
  }
}
