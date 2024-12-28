import 'exports.dart';
import 'rick_and_morty_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Set system UI overlay styles
  _setSystemUIOverlayStyle();

  //! Restrict device orientation to portrait mode
  _setPreferredOrientations();

  //! Ensure screen size for responsive design
  await ScreenUtil.ensureScreenSize();
  //! Run the main application
  runApp(
    RickAndMortyApp(),
  );
}

//! Function to set system UI overlay styles
void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    systemNavigationBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
}

//! Function to set preferred device orientations
void _setPreferredOrientations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
