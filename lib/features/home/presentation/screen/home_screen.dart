import '../widgets/setup_home_bloc_builder.dart';

import '../../../../exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kSTEPDirectionalPadding,
          child: SetupCharactersBlocBuilder(),
        ),
      ),
    );
  }
}
