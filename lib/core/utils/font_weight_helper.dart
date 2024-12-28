import '../../exports.dart';

////! A utility class that provides static constants for various font weights
////! used throughout the application. This class cannot be instantiated.
class AppFontWeightHelper {
  AppFontWeightHelper._(); //! Private constructor to prevent instantiation

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
