import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/presentation/screens/search/search_screen.dart';
import 'package:matgry/shared/constants.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit=ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Matgry',
            ),
            actions:
            [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottom(index);
              print(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
