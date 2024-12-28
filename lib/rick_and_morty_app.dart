import 'exports.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //! Initialize ScreenUtil for responsive UI design only once
    ScreenUtil.init(context);
    ScreenUtil().statusBarHeight;
    //! Get screen width
    double screenWidth = MediaQuery.sizeOf(context).width;
    //! Set the design size dynamically based on screen size
    Size designSize;
    if (screenWidth >= 1440) {
      designSize = Size(1440, 2808); //! For large screens
    } else if (screenWidth >= 375) {
      designSize = Size(375, 1343); //! For medium screens
    } else {
      designSize = Size(360, 640); //! Default for small screens
    }
    return ScreenUtilInit(
      designSize: designSize, //! Base design size for scaling UI elements
      minTextAdapt: true, //! Text scaling according to screen size
      splitScreenMode: true, //! Handle split-screen mode
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick And Morty App',
        theme: appTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        navigatorKey: navigatorKey,
        // initialRoute:
        //     Routes., //! Initial route is the onboarding screen
        // home: const (),
      ),
    );
  }
}
