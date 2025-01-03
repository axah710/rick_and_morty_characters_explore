import 'setup_episodes_bloc_builder.dart';

import '../../../../core/widgets/logo_app_bar_widget.dart';
import '../../../../exports.dart';
import '../../data/models/character_details_arguments_model.dart';
import 'build_character_details_container_section.dart';
import 'build_planet_image_section.dart';

class CharacterDetailsBodySection extends StatelessWidget {
  final CharacterDetailsArgumentsModel characterDetails;

  const CharacterDetailsBodySection(
      {super.key, required this.characterDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoAppBarWidget(isPop: true),
        100.vs,
        Stack(
          clipBehavior:
              Clip.none, //! Allows elements to overflow outside the Stack
          children: [
            buildCharacterDetailsContainer(characterDetails),
            buildCharachterPlanetImage(),
          ],
        ),
        25.vs,
        Container(
          constraints: BoxConstraints(maxHeight: 300.h), 
          child: SetupEpisodesBlocBuilder(),
        ),
      ],
    );
  }
}
