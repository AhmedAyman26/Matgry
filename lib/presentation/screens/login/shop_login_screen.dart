import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/local/cache_helper.dart';
import 'package:matgry/presentation/screens/login/cubit/cubit.dart';
import 'package:matgry/presentation/screens/login/cubit/states.dart';
import 'package:matgry/presentation/screens/register/shop_register_screen.dart';
import 'package:matgry/presentation/screens/shop_layout/shop_layout_screen.dart';
import 'package:matgry/presentation/widgets/widgets.dart';
import 'package:matgry/shared/constants.dart';
class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSuccesState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
              {
                token =state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout(),);
              });
              // Toast.show(
              //   state.loginModel.message!,
              //   gravity: Toast.bottom,
              //   duration: Toast.lengthLong,
              //   backgroundColor: Colors.red
              // );
              // Fluttertoast.showToast(
              //     msg: state.loginModel.message!,
              //     toastLength: Toast.LENGTH_LONG,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
            }
            else
              {
                print(state.loginModel.message);
                // Fluttertoast.showToast(
                //     msg: state.loginModel.message!,
                //     toastLength: Toast.LENGTH_LONG,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 5,
                //     backgroundColor: Colors.red,
                //     textColor: Colors.white,
                //     fontSize: 16.0
                // );
              }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login to browse our hot offers!!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'you must enter email';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButtoun(
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }

                              },
                              text: 'Login',
                              background: Colors.green),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                              function: () {
                                navigateAndFinish(context, ShopRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
