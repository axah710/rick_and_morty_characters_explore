// ignore_for_file: deprecated_member_use


import '../../exports.dart';

class CustomAppBarWithBackArrowSection extends StatelessWidget {
  const CustomAppBarWithBackArrowSection(
      {super.key,
      required this.isPop,
      required this.appBarTitle,
      this.appBarColor});
  final bool isPop;
  final String appBarTitle;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isPop
              ? Expanded(
                  child: GestureDetector(
                    onTap: () {
                      canPop(context);
                    },
                    child: SvgPicture.asset(
                      AppAssets.arrowLeft,
                      color: appBarColor ?? AppColors.white,
                    ),
                  ).alignCenterStart(),
                )
              : const SizedBox.shrink(),
          Text(
            appBarTitle,
            style: getSemiBoldTextStyle(
              color: appBarColor ?? AppColors.white,
              fontSize: 18,
              height: 0,
            ),
          ),
          isPop ? const Spacer() : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
