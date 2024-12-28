import '../../../../exports.dart';

Widget buildCharacterAttribute(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: getBoldTextStyle(color: AppColors.white, fontSize: 24),
          ),
          TextSpan(
            text: value,
            style: getRegularTextStyle(color: AppColors.white, fontSize: 24),
          ),
        ],
      ),
    ),
  );
}
