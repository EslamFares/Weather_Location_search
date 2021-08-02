import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';
import 'package:weather_location_search/view/home/widgets/body_data.dart';
import 'package:weather_location_search/view/home/widgets/search_bar.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('weather'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            Expanded(
                child: cubit.loadingLocation
                    ? Center(child: CircularProgressIndicator())
                    : BodyData(cubit.locationWeatherModel)),
          ],
        ),
      ),
    );
  }
}
