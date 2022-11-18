
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgry/data/models/search_model.dart';
import 'package:matgry/data/web_services/dio_helper.dart';
import 'package:matgry/data/web_services/end_points.dart';
import 'package:matgry/presentation/screens/search/cubit/states.dart';
import 'package:matgry/shared/constants.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text' : text,
        },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}