import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/categories_model.dart';
import 'package:matgry/data/models/home_model.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/cubit/states.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).cateogriesModel != null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel! ,ShopCubit.get(context).cateogriesModel! , context),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productBuilder(HomeModel model, CategoriesModel catModel , context) => SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners.map((e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),).toList(),
            options: CarouselOptions(
              height: 250,

              initialPage: 0,
              reverse: false,
              // autoPlay: true,
              // autoPlayInterval: const Duration(seconds: 3),
              // autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => BuildCategoryItem(catModel.data.data[index]),
                    separatorBuilder: (context,index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: catModel.data.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.68,
              children: List.generate(
                model.data.products.length,
                (index) => buildGridProduct(model.data.products[index] , context),
              ),
            ),
          ),
        ],
      ),
    );

Widget BuildCategoryItem(DataModel model)=> Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
    Image(
      image: NetworkImage(model.image),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black.withOpacity(0.7),
      width: 100,
      child: Text(
        model.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white
        ),
      ),
    ),
  ],
);

Widget buildGridProduct(ProductModel model ,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if(model.discount!=0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'discount',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),
                  ),
                  color: Colors.red,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, height: 1.2),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if(model.discount!=0)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                    const Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        print(model.id);
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favourites[model.id]! ? Colors.greenAccent : Colors.grey,
                        child: const Icon(
                            Icons.favorite_border,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );


