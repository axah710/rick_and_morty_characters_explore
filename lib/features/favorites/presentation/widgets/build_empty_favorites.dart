import '../../../../exports.dart';

Widget buildEmptyFavorites() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.noFavoritesMessage,
          style: getBoldTextStyle(
            color: AppColors.white,
            fontSize: 20,
          ),
        ).alignCenterStart(),
        25.vs,
        SizedBox(
          width: 200.14.w,
          height: 250.3.h,
          child: CustomImageProviderFromAssetsAndNetwork(
            assetsImagePath: AppAssets.pickle,
            assetsImageHeight: 238.3,
            assetsImageWidth: 168.14,
          ),
        ),
      ],
    ),
  );
}
