import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/presentation/widgets/widgets.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/cubit/states.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: ConditionalBuilder(
            condition: state is !ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => CircularProgressIndicator(),
          ),
        );
      },
    );

  }
}
