import 'package:rick_and_morty_characters_explore/features/home/presentation/screen/home_screen.dart';
import 'exports.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //! Initialize ScreenUtil for responsive UI design only once
    ScreenUtil.init(context);
    ScreenUtil().statusBarHeight;
    //! Get screen width
    // double screenWidth = MediaQuery.sizeOf(context).width;
    //! Set the design size dynamically based on screen size
    // Size designSize = _getDesignSize(screenWidth);

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
        initialRoute: Routes.homeRoute,
        home: const HomeScreen(),
      ),
    );
  }

  // Size _getDesignSize(double screenWidth) {
  //   const double largeScreenWidth = 1440;
  //   const double mediumScreenWidth = 375;
  //   const Size largeScreenSize = Size(1440, 2808);
  //   const Size mediumScreenSize = Size(375, 1343);
  //   const Size smallScreenSize = Size(360, 640);

  //   if (screenWidth >= largeScreenWidth) {
  //     return largeScreenSize; //! For large screens
  //   } else if (screenWidth >= mediumScreenWidth) {
  //     return mediumScreenSize; //! For medium screens
  //   } else {
  //     return smallScreenSize; //! Default for small screens
  //   }
  // }
}
