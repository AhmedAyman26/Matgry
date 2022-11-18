import 'package:flutter/material.dart';
import 'package:matgry/shared/cubit/cubit.dart';

Widget defaultButtoun({
  double width = double.infinity,
  Color background = Colors.greenAccent,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onChange,
  Function()? onTap,
  required validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

Widget defaultTextButton({
  required function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'discount',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, height: 1.2),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style:
                        const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount!= 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // print(model.id);
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          ShopCubit.get(context).favourites[model.id!]!
                              ? Colors.greenAccent
                              : Colors.grey,
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
      ),
    );

showLoading(context)
{
  return showDialog(
    context: context,
    builder: (context)=>AlertDialog(
      title: Text('please wait'),
      content: Container(
          height: 50,
          child: Center(child: CircularProgressIndicator(),)),
    ),
  );
}

