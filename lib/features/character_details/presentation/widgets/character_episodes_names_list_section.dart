import '../../../../exports.dart';
import '../../../home/data/models/episodes/response/episodes_data_response_model.dart';
import 'episode_card_section.dart';

class CharacterEpisodesNamesListSection extends StatelessWidget {
  final List<EpisodesDataResponseModel> episodesDataResponseModel;

  const CharacterEpisodesNamesListSection(
      {super.key, required this.episodesDataResponseModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: episodesDataResponseModel.length,
      padding: 10.pv,
      itemBuilder: (context, index) {
        return EpisodeCardSection(
          episode: episodesDataResponseModel[index],
          index: index,
        );
      },
    );
  }
}
