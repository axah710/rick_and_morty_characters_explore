import '../../../../exports.dart';

Widget buildCharachterPlanetImage() {
  return Positioned(
    top: -50.h,
    left: 0,
    right: 0,
    child: Image.asset(
      AppAssets.planet,
      height: 100.h,
    ),
  );
}
