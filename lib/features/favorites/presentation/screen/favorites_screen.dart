import 'package:rick_and_morty_characters_explore/features/favorites/presentation/widgets/favorites_body_section.dart';

import '../../../../exports.dart';

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
