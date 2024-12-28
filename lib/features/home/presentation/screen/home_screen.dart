import 'package:rick_and_morty_characters_explore/features/home/presentation/widgets/home_screen_body_section.dart';

import '../../../../exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kSTEPDirectionalPadding,
          child: HomeScreenBodySection(),
        ),
      ),
    );
  }
}
