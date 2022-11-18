import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/presentation/widgets/widgets.dart';
import 'package:matgry/shared/constants.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.isEmpty) {
                          print('name must not be empty');
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          print('email must not be empty');
                        }
                      },
                      label: 'Email',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          print('phone must not be empty');
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButtoun(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                      },
                      text: 'UPDATE',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButtoun(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'LOG OUT',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
