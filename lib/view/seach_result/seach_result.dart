import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';
import 'package:weather_location_search/view/home/widgets/body_data.dart';

class SearchReasult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: cubit.loading
          ? Center(child: CircularProgressIndicator())
          : cubit.noData
              ? Center(child: Text('city not found'))
              : BodyData(cubit.searchWeatherModel),
    );
  }
}
