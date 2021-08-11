import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
  bool noData = true;
  bool noDataLocation = false;
  late WeatherModel searchWeatherModel;
   WeatherModel? locationWeatherModel;
  clearSearch() {
    loading = true;
    emit(HomeChangeLoadingState());
  }

  String myID = '2db8334a16a6a509e314680779471b9b';
  void getWeather() async {
    Response<dynamic>? value;
    try {
      value = await DioHelper.getData(url: 'data/2.5/weather?', query: {
        'appid': myID,
        'q': searchController.text,
        'units': 'imperial'
      });
    } catch (e) {
      print('errrrrrrrrror catch ==>$e');
    }

    if (value != null) {
      print("city found");
      searchWeatherModel = WeatherModel.fromJson(value.data);
      emit(HomeChangeSearchWeatherState());
      noData = false;
      emit(HomeChangeNODataState());
      loading = false;
      emit(HomeChangeLoadingState());
      print(' Data =====>${searchWeatherModel.name}');
    } else {
      print("city not found");
      loading = false;
      emit(HomeChangeLoadingState());
      noData = true;
      emit(HomeChangeNODataState());
    }
  }

//=====================================

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
        'units': 'imperial'
      });
    } catch (e) {
      print('errrrrrrrrror catch ==>$e');
    }

    if (value != null) {
      print("city found");
      locationWeatherModel = WeatherModel.fromJson(value.data);
      emit(HomeChangeLocationWeatherState());
      print(' Data =====>${locationWeatherModel?.name}');
      loadingLocation = false;
      emit(HomeChangeLoadingLocationState());
      noDataLocation = false;
      emit(HomeChangeNODataLocationState());
    } else {
      print("city not found");
      loadingLocation = false;
      emit(HomeChangeLoadingLocationState());
      noDataLocation = true;
      emit(HomeChangeNODataLocationState());
    }
  }

  //======================
  bool locationReqDeny = false;
  late PermissionStatus permission;
  getLocationPermission() async {
    permission = await Permission.locationWhenInUse.request();
    if (permission.isDenied) {
      print('location isDenied..❌❌❌..');
      locationReqDeny = true;
      emit(HomeChangeLocationReqState());
    }
    if (permission.isGranted) {
      print('location Granted..✔️✔️✔️..');
      getWeatherByLocation();
      locationReqDeny = false;
      emit(HomeChangeLocationReqState());
    }
    if (!permission.isGranted) {
      print('location Granted..❌✔️..');
      locationReqDeny = true;
      emit(HomeChangeLocationReqState());
    }
    // if (permission.isPermanentlyDenied) {
    //   print('location isPermanentlyDenied ..❗❗❗..');
    //   locationReqDeny = true;
    //   emit(HomeChangeLocationReqState());
    //   // openAppSettings();
    //   // getLocationSettinng = true;
    //   // emit(HomeChangeGetLocationSettinngState());
    // }
  }

  getDataAfterSetting() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      print('location Granted..✔️✔️✔️..');
      getWeatherByLocation();
      locationReqDeny = false;
      emit(HomeChangeLocationReqState());
    }
    if (!status.isGranted) {
      print('location Granted..❌✔️..');
      openAppSettings();
      locationReqDeny = true;
      emit(HomeChangeLocationReqState());
    }
    // if (permission.isPermanentlyDenied) {
    //   print('location isPermanentlyDenied ..❗❗❗..');
    //   locationReqDeny = true;
    //   emit(HomeChangeLocationReqState());
    //   // openAppSettings();
    //   // getLocationSettinng = true;
    //   // emit(HomeChangeGetLocationSettinngState());
    // }
  }
}
