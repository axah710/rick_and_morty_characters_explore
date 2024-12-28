import '../../exports.dart';
class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  // Padding inside the text field.
  final InputBorder? focusedBorder;
  // Border style when the text field is focused.
  final TextStyle? inputStyle;
  // Text style for the input text.
  final TextStyle? hintStyle;
  // Text style for the hint text.
  final bool? isObscureText;
  // Whether the text field should obscure the text (useful for passwords).
  final String hintText;
  // The hint text displayed when the text field is empty.
  final Widget? suffixIcon;
  // An optional widget to display at the end of the text field.
  final Widget? prefixIcon;
  final Color? fillColor;
  // Background color of the text field.
  final TextEditingController? controller;
  // final Function(String?) validator;
  final Function(String?)? validator;
  final Color? enabledBorderSideColor;
  final Color? focusdBorderColor;
  final int? radius;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? cursorColor;
  final double? height;
  final double? width;
  final double? enabledBorderSideWidth;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.inputStyle,
    this.hintStyle,
    this.isObscureText,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor,
    this.controller,
    this.radius,
    this.enabledBorderSideColor,
    this.labelText,
    this.labelStyle,
    this.focusdBorderColor,
    this.cursorColor,
    this.validator,
    this.height,
    this.width,
    this.enabledBorderSideWidth,
    this.minLines,
    this.maxLines,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,

        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        controller: controller,
        // controller manages the text being edited.

        validator: validator != null ? (value) => validator!(value) : null,
        // validator is a function that checks if the text input is valid and
        // returns an error message if it isn't.

        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          // The InputDecoration object customizes the appearance of the TextFormField
          isDense: false, // Only dense if no custom height is specified
          // isDense: true: Reduces the height of the text field.
          contentPadding: contentPadding ??
              // contentPadding: Uses the provided contentPadding or defaults to
              // horizontal and vertical padding values.
              EdgeInsets.symmetric(
                horizontal: 23.0.w,
                vertical: 16.0.h,
              ),
          focusedBorder: focusedBorder ??
              // focusedBorder: Uses the provided focusedBorder or defaults to an
              // OutlineInputBorder with a specific color and width.
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  radius?.r ?? 0,
                ),
                borderSide: BorderSide(
                  color: focusdBorderColor ?? AppColors.black,
                  width: 1.3.w,
                ),
              ),
          enabledBorder: OutlineInputBorder(
            // enabledBorder: Defines the border when the text field is not focused,
            // using a lighter gray color.
            borderRadius: BorderRadius.circular(
              radius?.r ?? 0,
            ),
            borderSide: BorderSide(
              color: enabledBorderSideColor ?? AppColors.black,
              width: enabledBorderSideWidth?.w ?? 1.w,
            ),
          ),
          hintStyle: hintStyle ?? getMediumTextStyle(),
          // hintStyle: Uses the provided hintStyle or defaults to a predefined text style.
          hintText: hintText,
          // hintText: Displays the provided hint text.
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.black,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.black,
          // suffixIcon: Displays the provided suffix icon, if any.

          fillColor: fillColor ?? AppColors.black,
          // fillColor: Uses the provided fillColor or defaults to a light gray color.
          filled: true,
          // filled: true: Ensures the text field is filled with the background color.
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              radius?.r ?? 0,
            ),
            borderSide: BorderSide(
              color: AppColors.black,
              width: 1.w,
            ),
          ),
          // errorBorder set the border styles when there is a validation error.
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              radius?.r ?? 0,
            ),
            borderSide: BorderSide(
              color: AppColors.black,
              width: 1.w,
            ),
          ),
          // focusedErrorBorder set the border styles when there is a validation
          // error.
        ),
        cursorColor: cursorColor ?? AppColors.black,
        // cursorColor: Sets the color of the cursor to the primary blue color.
        obscureText: isObscureText ?? false,
        // obscureText: Uses the provided isObscureText value or defaults to false.
        style: inputStyle ?? getMediumTextStyle(),
        // style: Uses the provided inputStyle or defaults to a predefined text style.
      ),
    );
  }
}
// AppTextFormField, which is a specialized text input field for a Flutter
// application. This widget is designed to be reusable and customizable,
// with several properties that allow for flexible styling and behavior.
