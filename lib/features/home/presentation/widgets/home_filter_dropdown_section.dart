import '../../../../exports.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_build_dropdown.dart';

class HomeFilterDropdownSection extends StatelessWidget {
  final HomeCubit cubit;
  const HomeFilterDropdownSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildDropdown(
          context: context,
          value: cubit.statusFilter,
          hint: AppStrings.selectStatus,
          items: AppStrings.statusItems,
          onChanged: (value) => cubit.updateSearchAndFilters(status: value),
        ),
        16.hs,
        buildDropdown(
          context: context,
          value: cubit.speciesFilter,
          hint: AppStrings.selectSpecies,
          items: AppStrings.speciesItems,
          onChanged: (value) => cubit.updateSearchAndFilters(species: value),
        ),
      ],
    );
  }
}
