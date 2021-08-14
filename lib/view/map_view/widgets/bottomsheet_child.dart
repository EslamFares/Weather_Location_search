import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home_bloc/home_cubit.dart';
import 'package:weather_location_search/view/home_view/widgets/body_data.dart';

class BottomSheetChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    HomeCubit cubit = HomeCubit.get(context);
    return Container(
      height: h * .5,
      child: cubit.maploadingLocation
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 30,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_down)),
                ),
                Expanded(child: BodyData(cubit.mapWeatherModel)),
              ],
            ),
    );
  }
}
