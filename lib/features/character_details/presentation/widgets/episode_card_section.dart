import '../../../../exports.dart';
import '../../../home/data/models/episodes/response/episodes_data_response_model.dart';

class EpisodeCardSection extends StatelessWidget {
  final EpisodesDataResponseModel episode;
  final int index;

  const EpisodeCardSection(
      {super.key, required this.episode, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 4.r,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.lightPurple, width: 1.5.w),
        ),
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.lightPurple,
              child: Text(
                episode.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            12.hs,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.name,
                    style: getBoldTextStyle(
                      color: AppColors.lightPurple,
                      fontSize: 16.0,
                    ),
                  ),
                  4.vs,
                  Text(
                    'Episode ${index + 1}',
                    style: getRegularTextStyle(
                      color: AppColors.lightPurple,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
