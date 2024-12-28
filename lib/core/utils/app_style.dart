import '../../exports.dart';

TextStyle getBoldTextStyle({
  double fontSize = 24,
  Color? color = AppColors.black,
  String? fontFamily = AppFontFamilies.fontFamilyOpenSans,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
  List<Shadow>? shadows,
}) {
  return TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: AppFontWeightHelper.bold,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
      shadows: shadows);
}

// Primary Text Style
TextStyle getRegularTextStyle({
  double fontSize = 14,
  Color? color,
  FontWeight? fontWeight,
  String fontFamily = AppFontFamilies.fontFamilyOpenSans,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

TextStyle getMediumTextStyle({
  double fontSize = 16,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily = AppFontFamilies.fontFamilyOpenSans,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

// Secondary Text Style
TextStyle getSemiBoldTextStyle({
  double fontSize = 14,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily = AppFontFamilies.fontFamilyOpenSans,
  double? letterSpacing,
  FontStyle? fontStyle,
  double? wordSpacing,
  TextDecoration? decoration,
  TextDecorationStyle? textDecorationStyle,
  TextBaseline? textBaseline,
  Color? decorationColor,
  Color? backgroundColor,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: AppFontWeightHelper.semiBold,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
    height: height,
  );
}

ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
      backgroundColor: AppColors.transparent,
      side: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    );
