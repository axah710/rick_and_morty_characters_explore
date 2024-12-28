import '../../exports.dart';

class CustomImageProviderFromAssetsAndNetwork extends StatelessWidget {
  final String assetsImagePath;
  final double assetsImageHeight;
  final double? assetsImageWidth;
  final BoxFit? assetImagefit;
  final double? assetsImageRadius;
  final bool isNetworkImage;
  const CustomImageProviderFromAssetsAndNetwork({
    this.isNetworkImage = false,
    super.key,
    required this.assetsImagePath,
    required this.assetsImageHeight,
    this.assetsImageWidth,
    this.assetImagefit,
    this.assetsImageRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(assetsImageRadius?.r ?? 0),
      child: isNetworkImage
          ? Image.network(
              assetsImagePath,
              height: assetsImageHeight.h,
              width: assetsImageWidth?.w ?? double.infinity.w,
              fit: BoxFit.cover,
            )
          : Image.asset(
              assetsImagePath,
              height: assetsImageHeight.h,
              width: assetsImageWidth?.w ?? double.maxFinite.w,
              fit: assetImagefit ?? BoxFit.cover,
            ),
    );
  }
}
