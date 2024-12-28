
import '../../exports.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.leftIcon,
      this.rightIcon,
      this.boxShadow,
      required this.onPressed,
      required this.text,
      this.color,
      this.padding,
      this.side = BorderSide.none,
      this.radius = 10,
      this.height,
      this.elevation,
      this.width,
      this.textColor = AppColors.white,
      this.style,
      this.margin});
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function()? onPressed;
  final Widget? leftIcon;
  final String text;
  final Widget? rightIcon;
  final double? height;
  final double? width;
  final Color? textColor;
  final double? radius;
  final BorderSide side;
  final Color? color;
  final TextStyle? style;
  final double? elevation;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return _buildButton;
  }

  get _buildButton => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!), side: side),
          padding: padding ?? EdgeInsetsDirectional.symmetric(vertical: 13.h),
        ),
        onPressed: onPressed,
        child: _buildButtonContent,
      );

  get _buildButtonContent => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leftIcon.isNotNull) leftIcon!,
          if (leftIcon.isNotNull)
            const SizedBox(
              width: 10,
            ),
          Text(
            text,
            textScaler: const TextScaler.linear(1),
            textAlign: TextAlign.center,
            style: style ??
                getBoldTextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
          ),
          if (rightIcon.isNotNull) rightIcon!,
        ],
      );
}
