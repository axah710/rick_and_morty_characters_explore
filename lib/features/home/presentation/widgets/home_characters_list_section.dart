import '../../../../exports.dart';
import 'character_data_model_dummy_data.dart';
import 'home_character_card_section.dart';

class HomeCharactersListSection extends StatelessWidget {
  const HomeCharactersListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: characterDataList.length,
        itemBuilder: (context, index) {
          return HomeCharacterCardSection(
              characterData: characterDataList[index]);
        },
      ),
    );
  }
}
