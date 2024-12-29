import '../../../../core/widgets/logo_app_bar_widget.dart';
import '../../../../exports.dart';
import '../../../home/presentation/widgets/home_characters_paginated_list_section.dart';

class FavoritesBodySection extends StatelessWidget {
  const FavoritesBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LogoAppBarWidget(isPop: true),
        25.vs,
        CustomImageProviderFromAssetsAndNetwork(
          assetsImagePath: AppAssets.favorites,
          assetsImageHeight: 100.0,
        ),
        25.vs,
        Expanded(
          child: HomeFiltersAndPaginatedListSection(),
        ),
      ],
    );
  }
}
