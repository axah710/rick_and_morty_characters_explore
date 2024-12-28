import '../../exports.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.darkPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: null,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    textTheme: getTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 0.h),
      hintStyle: getMediumTextStyle(
        color: AppColors.hintColor,
        fontSize: 14.sp,
        height: 26.24.sp / 14.sp,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1.w),
      ),
    ),
  );
}

TextTheme? getTextTheme() {
  final textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
    bodyLarge: TextStyle(
      fontSize: 22,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      color: AppColors.deepGray,
      fontFamily: AppFontFamilies.fontFamilyOpenSans,
    ),
  );
  return textTheme;
}
