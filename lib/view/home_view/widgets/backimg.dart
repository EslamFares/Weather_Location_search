import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home_bloc/home_cubit.dart';

class BackImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    HomeCubit cubit = HomeCubit.get(context);

    int temp = cubit.locationWeatherModel != null
        ? ((double.parse(cubit.locationWeatherModel!.main!.temp.toString()) -
                    32) *
                (5 / 9))
            .round()
        : 0;
    String img = temp > 20 ? 'assets/img/cloud.jpeg' : 'assets/img/rain.jpg';
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: cubit.locationWeatherModel != null
          ? Image.asset(
              img,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }
}