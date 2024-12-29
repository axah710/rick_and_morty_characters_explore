import '../core/utils/debug_prints.dart';
import '../exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //! Counter to track timer ticks
  int counter = 0;

  //! Stores the route name for navigation after the splash screen
  String? route;

  Timer? timer;

  nextScreen() {
    timer = Timer.periodic(1.seconds, (timer) {
      counter++;
      if (route.isNotNull && counter >= AppConstants.splashScreenTime) {
        route!.moveToAndRemoveCurrent(); //! Navigate and remove splash screen
        timer.cancel();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      route = Routes.homeRoute;

      Logger.printInfo("route is $route");
    });
  }

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageProviderFromAssetsAndNetwork(
            assetsImagePath: AppAssets.splashScreen,
            assetsImageHeight: context.screenHeight,
            assetsImageWidth: context.screenWidth,
            assetImagefit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
