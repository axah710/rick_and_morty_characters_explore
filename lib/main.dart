import 'package:flutter_bloc/flutter_bloc.dart';

import 'exports.dart';
import 'global_bloc_observer.dart';
import 'rick_and_morty_app.dart';
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Set system UI overlay styles
  _setSystemUIOverlayStyle();

  //! Restrict device orientation to portrait mode
  _setPreferredOrientations();

  //! Ensure screen size for responsive design
  await ScreenUtil.ensureScreenSize();

  //! Initialize all dependencies with error handling
  final serviceLocator = ServiceLocator();
  await serviceLocator.init(); //! Ensure all services are registered

  //! Initialize Bloc observer for state management
  Bloc.observer = GlobalBlocObserver();

  //! Run the main application
  runApp(
    RickAndMortyApp(),
  );
}

//! Function to set system UI overlay styles
void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      systemNavigationBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

//! Function to set preferred device orientations
void _setPreferredOrientations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
