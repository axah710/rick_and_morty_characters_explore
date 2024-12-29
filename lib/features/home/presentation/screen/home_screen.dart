import 'package:rick_and_morty_characters_explore/core/widgets/svg_displayer.dart';
import '../../../../exports.dart';
import '../widgets/setup_home_bloc_builder.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context, List<ConnectivityResult> connectivity, Widget child) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);
          return Stack(
            fit: StackFit.expand,
            children: [
              connected ? _buildConnectedContent() : _buildDisconnectedContent(),
            ],
          );
        },
        child: const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildConnectedContent() {
    return Padding(
      padding: AppConstants.kSTEPDirectionalPadding,
      child: const SetupCharactersBlocBuilder(),
    );
  }

  Widget _buildDisconnectedContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgDisplayer(
            assetName: AppAssets.wifi,
            height: 145.h,
            width: 176.w,
            svgIconColor: AppColors.white,
          ),
          24.5.vs,
          Text(
            AppStrings.whoops,
            style: getSemiBoldTextStyle(fontSize: 24, color: AppColors.white),
          ),
          12.vs,
          Text(
            AppStrings.connectionErrorAlert,
            textAlign: TextAlign.center,
            style: getRegularTextStyle(fontSize: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}