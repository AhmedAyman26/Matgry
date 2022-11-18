import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/login_model.dart';
import 'package:matgry/data/web_services/dio_helper.dart';
import 'package:matgry/data/web_services/end_points.dart';
import 'package:matgry/presentation/screens/login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModel loginModel ;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email' :email,
          'password' : password,
        }
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data!.token);
      ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccesState(loginModel));
    }).catchError((error)
    {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.remove_red_eye;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;

    emit(ShopChangePasswordVisibilityState());
  }

}