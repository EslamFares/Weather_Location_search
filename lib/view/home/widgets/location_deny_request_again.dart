import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';

class LocationDenyRequestAgain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('sorry to show weather data for your location'),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () async {
              cubit.getDataAfterSetting();
            },
            child: Text('Refresh'))
      ],
    ));
  }
}
