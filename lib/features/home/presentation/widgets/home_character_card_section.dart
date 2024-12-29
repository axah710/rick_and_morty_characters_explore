import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/base_state.dart';
import '../../../../exports.dart';
import '../../../character_details/data/models/character_details_arguments_model.dart';
import '../../../favorites/presentation/managers/cubit/favorites_cubit.dart';
import '../../data/models/response/character_data_response_model.dart';
import 'home_character_info_section.dart';

class HomeCharacterCardSection extends StatelessWidget {
  final CharacterDataResponseModel characterDataResponseModel;

  const HomeCharacterCardSection(
      {super.key, required this.characterDataResponseModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, CubitStates>(
      builder: (context, state) {
        bool isFavorited = false;
        if (state is LoadedState) {
          isFavorited = state.data
              .any((item) => item.id == characterDataResponseModel.id);
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 16.5.h),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.characterDetailRoute,
                arguments: CharacterDetailsArgumentsModel(
                  image: characterDataResponseModel.image,
                  name: characterDataResponseModel.name,
                  gender: characterDataResponseModel.gender,
                  species: characterDataResponseModel.species,
                  status: characterDataResponseModel.status,
                  location: characterDataResponseModel.location.name,
                  origin: characterDataResponseModel.origin.name,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(7.w, 6.h, 7.w, 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                color: AppColors.lightPurple,
              ),
              child: Row(
                children: [
                  CustomImageProviderFromAssetsAndNetwork(
                    assetsImagePath: characterDataResponseModel.image,
                    assetsImageHeight: 75.h,
                    assetsImageWidth: 75.w,
                    assetsImageRadius: 14.r,
                    isNetworkImage: true,
                  ),
                  15.hs,
                  Expanded(
                    child: HomeCharacterInfoSection(
                      characterDataResponseModel: characterDataResponseModel,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<FavoritesCubit>()
                          .toggleFavorite(characterDataResponseModel);
                    },
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? AppColors.red : AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
