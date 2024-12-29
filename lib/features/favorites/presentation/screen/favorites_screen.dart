import '../../../../exports.dart';
import '../widgets/favorites_body_section.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kSTEPDirectionalPadding,
          child: FavoritesBodySection(),
        ),
      ),
    );
  }
}
