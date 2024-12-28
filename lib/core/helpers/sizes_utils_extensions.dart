// ignore_for_file: unnecessary_this
import '../../exports.dart';

extension ScreenUtilExtension on num {
  //! Custom extension for horizontal spacing using 'hs'
  Widget get hs => SizedBox(width: this.w); // Example: 20.hs

  //! Custom extension for vertical spacing using 'vs'
  Widget get vs => SizedBox(height: this.h); // Example: 15.vs

  //! Creates EdgeInsetsDirectional with all sides having the same padding
  EdgeInsetsDirectional get all => EdgeInsetsDirectional.all(this.toDouble().r);
  // Example: Padding(padding: 10.all)

  //! Creates EdgeInsetsDirectional with specific start and end padding
  // EdgeInsetsDirectional startEnd(double end) =>
  //     EdgeInsetsDirectional.only(start: this.toDouble().w, end: end.w);
  // Example: Padding(padding: 8.startEnd(12))

  //! Creates EdgeInsetsDirectional with specific top and bottom padding
  // EdgeInsetsDirectional topBottom(double bottom) =>
  //     EdgeInsetsDirectional.only(top: this.toDouble().h, bottom: bottom.w);
  // Example: Padding(padding: 5.topBottom(10))

  //! Creates EdgeInsetsDirectional with horizontal padding using 'ph'
  EdgeInsetsDirectional get ph =>
      EdgeInsetsDirectional.symmetric(horizontal: this.toDouble().w);
  // Example: Padding(padding: 16.ph)

  //! Creates EdgeInsetsDirectional with vertical padding using 'pv'
  EdgeInsetsDirectional get pv =>
      EdgeInsetsDirectional.symmetric(vertical: this.toDouble().h);
  // Example: Padding(padding: 12.pv)

  //! Creates EdgeInsets with all sides having the same padding
  EdgeInsets get allEdgeInsets => EdgeInsets.all(this.toDouble().r);
  // Example: Container(margin: 20.allEdgeInsets)

  //! Creates EdgeInsets with specific padding for each side
  // EdgeInsets onlyEdgeInsets(
  //         {double? left, double? top, double? right, double? bottom}) =>
  //     EdgeInsets.only(
  //       left: left ?? this.toDouble().w,
  //       top: top ?? this.toDouble().h,
  //       right: right ?? this.toDouble().w,
  //       bottom: bottom ?? this.toDouble().h,
  //     );
  // Example: Container(padding: 8.onlyEdgeInsets(left: 10, bottom: 15))

  //! Creates EdgeInsets with symmetric padding
  // EdgeInsets symmetricEdgeInsets({double? vertical, double? horizontal}) =>
  //     EdgeInsets.symmetric(
  //       vertical: vertical ?? this.toDouble().h,
  //       horizontal: horizontal ?? this.toDouble().w,
  //     );
  // Example: Container(padding: 10.symmetricEdgeInsets(vertical: 20))
}

extension BuildContextExtension on BuildContext {
  //! Access MediaQuery easily
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  //! Get screen width
  double get screenWidth => mediaQuery.size.width;
  // Example:
  // double width = context.screenWidth;

  //! Get screen height
  double get screenHeight => mediaQuery.size.height;
  // Example:
  // double height = context.screenHeight;

  //! Check orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  // Example:
  // if (context.isPortrait) {
  // Perform action for portrait mode
  // } else {
  // Perform action for landscape mode
  // }
}
