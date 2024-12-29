import '../core/utils/debug_prints.dart';
import '../exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    timer = Timer(Duration(seconds: AppConstants.splashScreenDuration), () {
      Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      Logger.printInfo("Navigating to home route");
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomImageProviderFromAssetsAndNetwork(
        assetsImagePath: AppAssets.splashScreen,
        assetsImageHeight: context.screenHeight,
        assetsImageWidth: context.screenWidth,
        assetImagefit: BoxFit.fill,
      ),
    );
  }
}
