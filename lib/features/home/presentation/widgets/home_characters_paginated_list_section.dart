import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../exports.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_filter_dropdown_section.dart';
import 'home_paginated_list.dart';

class HomeDropdownFiltersAndPaginatedListSection extends StatelessWidget {
  const HomeDropdownFiltersAndPaginatedListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCharactersCubit = context.read<HomeCubit>();
    return Column(
      children: [
        //! Filters
        HomeFilterDropdownSection(
          cubit: homeCharactersCubit,
        ),
        16.vs,
        //! Paginated List
        HomePaginatedListSection(
          cubit: homeCharactersCubit,
        ),
      ],
    );
  }
}
