import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../exports.dart';
import '../../data/models/response/character_data_response_model.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_character_card_section.dart';

class HomeFiltersAndPaginatedListSection extends StatelessWidget {
  const HomeFiltersAndPaginatedListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Column(
      children: [
        //! Filters
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF8879b5),
                  borderRadius: BorderRadius.circular(12.0.r),
                  border: Border.all(color: AppColors.transparent),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: AppColors.lightPurple,
                    value: cubit.statusFilter,
                    hint: Text(
                      'Select Status',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.white,
                      ),
                    ),
                    items: ['Alive', 'Dead', 'unknown']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(
                                status,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.white,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateSearchAndFilters(status: value);
                    },
                    icon: Icon(Icons.arrow_drop_down, color: AppColors.white),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0.w),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple,
                  borderRadius: BorderRadius.circular(12.0.r),
                  border: Border.all(color: AppColors.transparent),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: AppColors.lightPurple,
                    value: cubit.speciesFilter,
                    hint: Text(
                      'Select Species',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.white,
                      ),
                    ),
                    items: ['Human', 'Alien', 'Robot']
                        .map((species) => DropdownMenuItem(
                              value: species,
                              child: Text(
                                species,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.white,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateSearchAndFilters(species: value);
                    },
                    icon: Icon(Icons.arrow_drop_down, color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        16.vs,

        //! Paginated List
        Expanded(
          child: PagedListView<int, CharacterDataResponseModel>(
            pagingController: cubit.pagingController,
            builderDelegate:
                PagedChildBuilderDelegate<CharacterDataResponseModel>(
              itemBuilder: (context, character, index) =>
                  HomeCharacterCardSection(
                characterDataResponseModel: character,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
