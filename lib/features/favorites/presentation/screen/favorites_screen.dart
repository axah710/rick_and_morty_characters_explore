import '../../../../exports.dart';
import '../widgets/setup_favorites_bloc_builder.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kSTEPDirectionalPadding,
          child: SetupFavoritesBlocBuilder(),
        ),
      ),
    );
  }
}
