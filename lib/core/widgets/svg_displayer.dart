import '../../exports.dart';

class SvgDisplayer extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? svgIconColor;
  final BoxFit? fit;
  const SvgDisplayer(
      {super.key,
      required this.assetName,
      this.height,
      this.width,
      this.svgIconColor,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      // ignore: deprecated_member_use
      color: svgIconColor,
      height: height,
      width: width,
      assetName,
      fit: fit ?? BoxFit.contain,
    );
    // SvgPicture.asset(assetName): This line uses the SvgPicture.asset
    //constructor from the flutter_svg package to create a widget that displays
    //the SVG image specified by assetName.
  }
}
// In summary, the SvgDisplayer widget is a simple, reusable component that
// takes the name of an SVG asset as a parameter and displays that SVG image
// using the flutter_svg package. This widget can be used in a Flutter
//application wherever an SVG image needs to be displayed.
