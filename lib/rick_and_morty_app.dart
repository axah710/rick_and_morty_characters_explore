import 'package:rick_and_morty_characters_explore/features/splash_screen.dart';
import 'exports.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //! Initialize ScreenUtil for responsive UI design only once
    ScreenUtil.init(context);
    ScreenUtil().statusBarHeight;
    return ScreenUtilInit(
      designSize: Size(360, 690), //! Base design size for scaling UI elements
      minTextAdapt: true, //! Text scaling according to screen size
      splitScreenMode: true, //! Handle split-screen mode
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        theme: appTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splashScreen,
        home: const SplashScreen(),
      ),
    );
  }

}
