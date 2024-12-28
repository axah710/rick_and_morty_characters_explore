import 'package:rick_and_morty_characters_explore/features/character_details/presentation/widgets/character_details_body_section.dart';

import '../../../../exports.dart';
import '../../data/models/character_details_arguments_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterDetailsArgumentsModel characterDetails;

  const CharacterDetailsScreen({super.key, required this.characterDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kSTEPDirectionalPadding,
          child: SingleChildScrollView(
            child: CharacterDetailsBodySection(
              characterDetails: characterDetails,
            ),
          ),
        ),
      ),
    );
  }
}
