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
            _buildDropdown(
              context: context,
              value: cubit.statusFilter,
              hint: 'Select Status',
              items: ['Alive', 'Dead', 'unknown'],
              onChanged: (value) => cubit.updateSearchAndFilters(status: value),
            ),
            SizedBox(width: 16.0.w),
            _buildDropdown(
              context: context,
              value: cubit.speciesFilter,
              hint: 'Select Species',
              items: ['Human', 'Alien', 'Robot'],
              onChanged: (value) =>
                  cubit.updateSearchAndFilters(species: value),
            ),
          ],
        ),
        SizedBox(height: 16.0), // Fixed the height space
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

  Widget _buildDropdown({
    required BuildContext context,
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Flexible(
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
            value: value,
            hint: Text(
              hint,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.white,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.white,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            icon: Icon(Icons.arrow_drop_down, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
