import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/bloc_observer.dart';
import 'package:matgry/data/local/cache_helper.dart';
import 'package:matgry/data/web_services/dio_helper.dart';
import 'package:matgry/presentation/screens/login/shop_login_screen.dart';
import 'package:matgry/presentation/screens/on_boarding/on_boarding_screen.dart';
import 'package:matgry/presentation/screens/shop_layout/shop_layout_screen.dart';
import 'package:matgry/shared/constants.dart';
import 'package:matgry/shared/cubit/cubit.dart';
import 'package:matgry/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  late Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  }
  else {
    widget = OnBoardingScreen();
  }

  print(onBoarding);
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
