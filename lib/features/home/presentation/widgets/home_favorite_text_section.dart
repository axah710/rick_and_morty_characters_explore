import '../../../../exports.dart';

class HomeFavoriteTextSection extends StatelessWidget {
  const HomeFavoriteTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.favoritesRoute.moveTo();
      },
      child: Text(
        AppStrings.favoriteCharacters,
        style: getMediumTextStyle(
          color: AppColors.white,
          fontSize: 20.0,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.white,
        ),
      ).alignCenterEnd(),
    );
  }
}
