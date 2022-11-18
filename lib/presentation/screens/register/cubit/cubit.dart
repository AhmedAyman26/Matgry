import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/login_model.dart';
import 'package:matgry/data/web_services/dio_helper.dart';
import 'package:matgry/data/web_services/end_points.dart';
import 'package:matgry/presentation/screens/register/cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModel LoginModel ;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'email' :email,
          'password' : password,
          'phone' : phone,
        }
    ).then((value)
    {
      print(value.data);
      LoginModel = ShopLoginModel.fromJson(value.data);
      // print(RegisterModel.status);
      // print(RegisterModel.message);
      // print(RegisterModel.data!.token);
      ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(LoginModel));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.remove_red_eye;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;

    emit(ShopRegisterChangePasswordVisibilityState());
  }

}