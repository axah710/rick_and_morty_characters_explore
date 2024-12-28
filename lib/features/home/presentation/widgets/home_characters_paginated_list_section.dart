import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../exports.dart';
import '../../data/models/response/character_data_response_model.dart';
import '../managers/home_cubit/home_cubit.dart';
import 'home_character_card_section.dart';

class HomeCharactersPaginatedListSection extends StatefulWidget {
  const HomeCharactersPaginatedListSection({super.key});

  @override
  State<HomeCharactersPaginatedListSection> createState() =>
      _HomeCharactersPaginatedListSectionState();
}

class _HomeCharactersPaginatedListSectionState
    extends State<HomeCharactersPaginatedListSection> {
  final PagingController<int, CharacterDataResponseModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cubit = context.read<HomeCubit>();
      await cubit.fetchCharacters(page: pageKey);
      _handleFetchedData(cubit.characterDataResponseModel?.data ?? [], pageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _handleFetchedData(List<CharacterDataResponseModel> data, int pageKey) {
    final isLastPage = data.length < AppConstants.pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(data);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(data, nextPageKey);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, CharacterDataResponseModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<CharacterDataResponseModel>(
        itemBuilder: (context, item, index) => HomeCharacterCardSection(
          characterDataResponseModel: item,
        ),
        firstPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text(
            AppStrings.noCharactersFound,
            style: getRegularTextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
