import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/categories_model.dart';
import 'package:matgry/presentation/widgets/widgets.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => BuildCatItem(ShopCubit.get(context).cateogriesModel!.data.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).cateogriesModel!.data.data.length,
        );
      },
    );
  }

  Widget BuildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children:
          [
            Image(
              image: NetworkImage(
                model.image,
              ),
              height: 100,
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                  Icons.arrow_forward_ios
              ),
            )

          ],
        ),
      );
}
