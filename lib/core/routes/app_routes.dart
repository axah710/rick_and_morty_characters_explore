import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters_explore/features/home/domain/home_use_case/home_use_case.dart';
import 'package:rick_and_morty_characters_explore/features/home/presentation/managers/home_cubit/home_cubit.dart';

import '../../exports.dart';
import '../../features/character_details/data/models/character_details_arguments_model.dart';
import '../../features/character_details/presentation/screen/character_details_screen.dart';
import '../../features/favorites/presentation/screen/favorites_screen.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../service_locator.dart';

class Routes {
  Routes._(); //! Private constructor to prevent instantiation
  static final String splashScreen = '/';
  static const String homeRoute = '/home';
  static const String characterDetailRoute = '/characterDetail';
  static const String favoritesRoute = '/favorites';
}

class RouteGenerator {
  RouteGenerator._(); //! Private constructor to prevent instantiation
  AnimationType? pageRouteAnimationGlobal;
  static Duration pageRouteTransitionDurationGlobal = 400.milliseconds;
  static Route<T>? getRoute<T>(RouteSettings routeSettings) {
    debugPrint(routeSettings.name);
    switch (routeSettings.name) {
      case Routes.homeRoute:
        return buildPageRoute(
          child: BlocProvider(
            create: (context) => HomeCubit(
              getAllCharactersUseCase: ServiceLocator.getIt<HomeUseCase>(),
            )..fetchCharacters(),
            child: const HomeScreen(),
          ),
          routeSettings: routeSettings,
        );
      case Routes.characterDetailRoute:
        //! I made the code to use a model for passing arguments instead of
        //! passing four separate arguments. This adheres to clean code
        //! principles by reducing the number of arguments, making the code
        //! more testable and easier to read.
        final characterDetails =
            routeSettings.arguments as CharacterDetailsArgumentsModel;
        return buildPageRoute(
          child: CharacterDetailsScreen(characterDetails: characterDetails),
          routeSettings: routeSettings,
        );
      case Routes.favoritesRoute:
        return buildPageRoute(
          child: const FavoritesScreen(),
          routeSettings: routeSettings,
        );
    }
    //! TODO: In production or release mode, return `null`. In development or debug mode, use `No Route Found` to enhance the user experience (UX).
    return buildPageRoute<T>(
      child: Scaffold(
        body: Center(
          child: Text(
            "No Route Found!",
            style: getBoldTextStyle(color: AppColors.black, fontSize: 20),
          ),
        ),
      ),
      routeSettings: routeSettings,
    );
  }

  static Route<T> buildPageRoute<T>({
    required Widget child,
    AnimationType? pageRouteAnimation = AnimationType.fade,
    Duration? duration,
    RouteSettings? routeSettings,
  }) {
    if (pageRouteAnimation == AnimationType.rotate) {
      return PageRouteBuilder<T>(
        settings: routeSettings,
        pageBuilder: (context, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return RotationTransition(
              turns: ReverseAnimation(anim), child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == AnimationType.scale) {
      return PageRouteBuilder<T>(
        settings: routeSettings,
        pageBuilder: (context, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return ScaleTransition(scale: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == AnimationType.slide) {
      return PageRouteBuilder<T>(
        settings: routeSettings,
        pageBuilder: (context, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == AnimationType.slideBottomTop) {
      return PageRouteBuilder<T>(
        settings: routeSettings,
        pageBuilder: (context, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }

    return PageRouteBuilder<T>(
      settings: routeSettings,
      transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      reverseTransitionDuration: const Duration(milliseconds: 50),
      pageBuilder: (context, a1, a2) => child,
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
    );
  }
}
