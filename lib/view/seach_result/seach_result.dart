import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home_bloc/home_cubit.dart';
import 'package:weather_location_search/view/home_view/widgets/body_data.dart';

class SearchReasult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            cubit.clearSearch();
          },
        ),
      ),
      body: cubit.loading
          ? Center(child: CircularProgressIndicator())
          : cubit.noData
              ? Center(child: Text('city not found'))
              : BodyData(cubit.searchWeatherModel),
    );
  }
}
