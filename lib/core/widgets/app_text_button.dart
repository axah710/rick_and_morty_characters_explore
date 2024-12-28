import '../../exports.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  // Optional border radius for the button.
  final Color? backgroundColor;
  // Optional background color for the button.
  final double? horizontalPadding;
  // Optional horizontal padding for the button.
  final double? verticalPadding;
  // Optional vertical padding for the button.
  final double? buttonWidth;
  // Optional width for the button.
  final double? buttonHeight;
  // Optional height for the button.
  final String buttonText;
  // Required text to be displayed on the button.
  final TextStyle textStyle;
  // Required text style for the button text.
  final VoidCallback onPressed;
  // Required callback function to be executed when the button is pressed.
  final Color? borderColor; // Optional border color for the button.
  final double? borderSideWidth;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.borderColor,
    this.borderSideWidth,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 16.0.r,
            ),
          ),
        ),
        // shape: WidgetStateProperty.all<RoundedRectangleBorder>(...): Sets the
        // shape of the button to a rounded rectangle with a border radius. If
        //borderRadius is not provided, it defaults to 16.0.r.
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? AppColors.black,
        ),
        // backgroundColor: WidgetStatePropertyAll(...): Sets the background
        //color of the button. If backgroundColor is not provided, it defaults
        // to SeekrColorsManager.primaryBlueColor.
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 0.w,
            vertical: verticalPadding?.h ?? 0.h,
          ),
        ),
        // padding: WidgetStateProperty.all<EdgeInsets>(...): Sets the padding
        //inside the button. If horizontalPadding or verticalPadding are not
        // provided, they default to 12.w and 14.h respectively.
        // ),
        fixedSize: WidgetStateProperty.all(
          Size(
            buttonWidth?.w ?? double.maxFinite,
            buttonHeight?.h ?? 50.h,
          ),
        ),
        // fixedSize: WidgetStateProperty.all(...): Sets the fixed size of the
        //button. If buttonWidth or buttonHeight are not provided, they default
        //to double.maxFinite and 50.h respectively.
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(
            color: borderColor ?? Colors.transparent, // Set the border color.
            width: borderSideWidth?.w ??
                2.0.w, // You can customize the width here.
          ),
        ),
      ),
      onPressed: onPressed,
      // onPressed: onPressed: Sets the callback function to be executed when
      // the button is pressed.
      child: Text(
        buttonText,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
// This widget is designed to create a customizable text button using
//Flutter's TextButton widget.
