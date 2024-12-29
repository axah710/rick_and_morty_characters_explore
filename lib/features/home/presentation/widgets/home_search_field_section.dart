import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exports.dart';
import '../managers/home_cubit/home_cubit.dart';

class HomeSearchFieldSection extends StatelessWidget {
  const HomeSearchFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return AppTextFormField(
      onChanged: (value) {
        cubit.updateSearchAndFilters(query: value);
      },
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
      cursorColor: AppColors.commonColor,
      keyboardType: TextInputType.text,
    );
  }
}
