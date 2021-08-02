import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_location_search/model/weather_model.dart';
import 'package:weather_location_search/shared/dio_helper.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  bool loading = true;
  bool loadingLocation = true;
  bool noData = false;
  bool noDataLocation = false;
  late WeatherModel searchWeatherModel;
  late WeatherModel locationWeatherModel;

  String myID = '2db8334a16a6a509e314680779471b9b';
  void getWeather() async {
    Response<dynamic>? value;
    try {
      value = await DioHelper.getData(url: 'data/2.5/weather?', query: {
        'appid': myID,
        'q': searchController.text,
      });
    } catch (e) {
      print('errrrrrrrrror catch ==>$e');
    }

    if (value != null) {
      print("city found");
      searchWeatherModel = WeatherModel.fromJson(value.data);
      emit(HomeChangeSearchWeatherState());
      print(' Data =====>${searchWeatherModel.name}');
      loading = false;
      emit(HomeChangeLoadingState());
      noData = false;
      emit(HomeChangeNODataState());
    } else {
      print("city not found");
      loading = false;
      emit(HomeChangeLoadingState());
      noData = true;
      emit(HomeChangeNODataState());
    }
  }

//=====================================
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  void getWeatherByLocation() async {
     Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    
    Response<dynamic>? value;
    try {
      value = await DioHelper.getData(url: 'data/2.5/weather?', query: {
        'lat': position.latitude,
        'lon': position.longitude,
        'appid': myID,
      });
    } catch (e) {
      print('errrrrrrrrror catch ==>$e');
    }

    if (value != null) {
      print("city found");
      locationWeatherModel = WeatherModel.fromJson(value.data);
      emit(HomeChangeLocationWeatherState());
      print(' Data =====>${locationWeatherModel.name}');
      loadingLocation = false;
      emit(HomeChangeLoadingLocationState());
      noDataLocation = false;
      emit(HomeChangeNODataLocationState());
    } else {
      print("city not found");
      loading = false;
      emit(HomeChangeLoadingLocationState());
      noDataLocation = true;
      emit(HomeChangeNODataLocationState());
    }
  }
}
