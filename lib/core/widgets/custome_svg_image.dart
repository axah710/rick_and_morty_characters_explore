// ignore_for_file: deprecated_member_use

import '../../exports.dart';

class CustomSVGImage extends StatelessWidget {
  const CustomSVGImage({
    super.key,
    required this.asset,
    this.matchTextDirection = true,
    this.color,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  final String asset;
  final void Function()? onTap;
  final Color? color;
  final BoxFit fit;
  final bool matchTextDirection;

  @override
  Widget build(BuildContext context) {
    if (asset.contains("http")) {
      return SvgPicture.network(
        asset,
        fit: BoxFit.fill,
        matchTextDirection: matchTextDirection,
        color: color,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        asset,
        color: color,
        fit: fit,
        matchTextDirection: matchTextDirection,
      ),
    );
  }
}
