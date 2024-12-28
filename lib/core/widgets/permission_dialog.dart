import '../../exports.dart';
import 'custom_elevated_button.dart';
import 'custome_svg_image.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final String description;
  final String asset;
  const PermissionDialog({
    required this.title,
    required this.description,
    required this.asset,
    super.key,
  });

  onAllowPressed() async {
    pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: AppColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 25.h, bottom: 60.h),
              child: CustomSVGImage(asset: asset),
            ),
            Text(title, style: getBoldTextStyle(fontSize: 20)),
            SizedBox(
              height: 16.h,
            ),
            Text(
              description,
              style: getMediumTextStyle(
                  fontSize: 16, color: AppColors.descriptionColor),
            ),
            SizedBox(
              height: 62.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onPressed: () => pop(true),
                  text: AppStrings.allow,
                  radius: 36.h,
                ),
                SizedBox(
                  height: 17.h,
                ),
                CustomElevatedButton(
                  onPressed: () => pop(false),
                  text: AppStrings.deny,
                  style: getMediumTextStyle(
                      color: AppColors.primaryColor, fontSize: 16.h),
                  color: AppColors.white,
                  radius: 36.h,
                  side: BorderSide(color: AppColors.primaryColor, width: 1.h),
                ),
                SizedBox(
                  height: 35.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
