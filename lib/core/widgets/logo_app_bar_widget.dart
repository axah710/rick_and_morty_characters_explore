import '../../exports.dart';

class LogoAppBarWidget extends StatelessWidget {
  const LogoAppBarWidget({super.key, required this.isPop});
  final bool isPop;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isPop
              ? Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        canPop(context);
                      },
                      child: SvgPicture.asset(
                        AppAssets.arrowLeft,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: 137.w,
            height: 35.33.h,
            child: Image.asset(AppAssets.appBarLogo, fit: BoxFit.fill),
          ),
          isPop ? const Spacer() : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
