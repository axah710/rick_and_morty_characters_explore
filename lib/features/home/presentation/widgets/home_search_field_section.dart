import '../../../../exports.dart';

class HomeSearchFieldSection extends StatelessWidget {
  const HomeSearchFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: AppStrings.searchCharacter,
      fillColor: AppColors.lightPurple,
      radius: 30,
      hintStyle: getSemiBoldTextStyle(
        color: AppColors.white,
        fontSize: 14,
      ),
      inputStyle: getSemiBoldTextStyle(
        color: AppColors.white,
        fontSize: 14,
      ),
      cursorColor: AppColors.primaryColor,
      keyboardType: TextInputType.text,
    );
  }
}
