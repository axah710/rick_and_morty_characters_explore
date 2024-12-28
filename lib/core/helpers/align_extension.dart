import '../../exports.dart';

extension AlignCenterStartExtension on Widget {
  Widget alignCenterStart() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: this,
    );
  }

  Widget alignCenterEnd() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: this,
    );
  }
}
