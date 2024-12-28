import 'package:rick_and_morty_characters_explore/features/character_details/data/models/character_details_arguments_model.dart';

import '../../../../core/widgets/logo_app_bar_widget.dart';
import '../../../../exports.dart';

class CharacterDetailsBodySection extends StatelessWidget {
  final CharacterDetailsArgumentsModel characterDetails;
  const CharacterDetailsBodySection({super.key, required this.characterDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoAppBarWidget(
          isPop: true,
        ),
        100.vs,
        Stack(
          clipBehavior:
              Clip.none, //! Allows elements to overflow outside the Stack
          children: [
            Container(
              width: double.infinity,
              // height: 354.8.h,
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
                  ),
                  8.vs,
                  Text(
                    characterDetails.name,
                    style: getBoldTextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                  ),
                  8.vs,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Species: ",
                              style: getBoldTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: characterDetails.species,
                              style: getRegularTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.vs,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Gender: ",
                              style: getBoldTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: characterDetails.gender,
                              style: getRegularTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.vs,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Status: ",
                              style: getBoldTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: characterDetails.status,
                              style: getRegularTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.vs,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Origin: ",
                              style: getBoldTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: characterDetails.origin,
                              style: getRegularTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.vs,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Location: ",
                              style: getBoldTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: characterDetails.location,
                              style: getRegularTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.vs,
                    ],
                  ).alignCenterStart(),
                ],
              ),
            ),
            Positioned(
              top: -50.h,
              left: 0,
              right: 0, //! Centers the image horizontally
              child: Image.asset(
                AppAssets.planet,
                height: 100.h,
              ),
            ),
          ],
        ),
        25.vs
      ],
    );
  }
}
