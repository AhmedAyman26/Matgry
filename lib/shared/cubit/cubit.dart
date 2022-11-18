import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/categories_model.dart';
import 'package:matgry/data/models/change_favorites_model.dart';
import 'package:matgry/data/models/favorites_model.dart';
import 'package:matgry/data/models/home_model.dart';
import 'package:matgry/data/models/login_model.dart';
import 'package:matgry/data/web_services/dio_helper.dart';
import 'package:matgry/data/web_services/end_points.dart';
import 'package:matgry/presentation/screens/categories/categories_screen.dart';
import 'package:matgry/presentation/screens/favourites/favourites_screen.dart';
import 'package:matgry/presentation/screens/products/products_screen.dart';
import 'package:matgry/presentation/screens/settings/settings_screen.dart';
import 'package:matgry/shared/constants.dart';
import 'package:matgry/shared/cubit/states.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context) =>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem>bottomItems=
  [
    BottomNavigationBarItem(
        icon: Icon(
            Icons.home
        ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.apps
        ),
      label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.favorite
        ),
      label: 'Favourites'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.settings
        ),
      label: 'Settings'
    ),
  ];

  List<Widget>screens =
  [
    ProductScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?,bool?> favourites ={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) 
      {
        favourites.addAll({
          element.id : element.inFavourites
        });
      });

      print(favourites.toString());

      emit(ShopSuccessHomeDataState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());

    });
  }

   CategoriesModel? cateogriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value)
    {
      cateogriesModel=CategoriesModel.fromJson(value.data);
      print(cateogriesModel.toString());
      emit(ShopSuccessCategoriesState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());

    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId)
  {
    favourites[productId] = ! favourites[productId]!;
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id' : productId,
      },
      token: token
    ).
    then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status)
        {
          favourites[productId] = ! favourites[productId]!;
        }else
          {
            getFavorites();
          }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error){
      favourites[productId] = ! favourites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(favoritesModel.toString());
      emit(ShopSuccessGetFavoritesState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());

    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);
      //print(favoritesModel.toString());
      emit(ShopSuccessUserDataState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());

    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);
      //print(favoritesModel.toString());
      emit(ShopSuccessUpdateUserDataState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());

    });
  }

}