import 'package:matgry/data/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccesState extends ShopLoginStates{

  late final ShopLoginModel loginModel;
  ShopLoginSuccesState(this.loginModel);

}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}
