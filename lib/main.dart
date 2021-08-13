import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_location_search/shared/bloc_observer.dart';
import 'package:weather_location_search/shared/dio_helper.dart';
import 'package:weather_location_search/shared/themes/dark_theme.dart';
import 'package:weather_location_search/view/map_view/map_screen.dart';

import 'cubit/home_bloc/home_cubit.dart';
import 'cubit/home_bloc/home_state.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HomeCubit()
            ..getLocationPermission()
            ),
     
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
            title: 'Weather',
            debugShowCheckedModeBanner: false,
            theme: darkTheme(),
            home: MapScreen() // HomeView(),
            ),
      ),
    );
  }
}
