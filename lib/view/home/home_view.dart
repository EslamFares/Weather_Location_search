import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';
import 'package:weather_location_search/view/home/widgets/body_data.dart';
import 'package:weather_location_search/view/home/widgets/search_bar.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('weather'),
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            Expanded(child: homeChild(context)
                // (cubit.locationReqDeny)
                //     ? LocationDenyRequestAgain()
                //     : cubit.loadingLocation
                //         ? Center(child: CircularProgressIndicator())
                //         : BodyData(cubit.locationWeatherModel)
                ),
          ],
        ),
      ),
    );
  }

  homeChild(context) {
    HomeCubit cubit = HomeCubit.get(context);
    if (cubit.locationReqDeny) {
      return LocationDenyRequestAgain();
    } else if (cubit.loadingLocation) {
      return Center(child: CircularProgressIndicator());
    } else if (cubit.loadingLocation == false) {
      return BodyData(cubit.locationWeatherModel);
    } else if (cubit.getLocationSettinng) {
      return ElevatedButton(
          onPressed: () async {
            cubit.getWeatherByLocation();
          },
          child: Text('Refresh'));
    }
    else{
      return Text('open setting and give app location permission ..');
    }
  }
}

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
              // await Permission.location.request();
              cubit.getLocationPermission();
            },
            child: Text('Location Allow'))
      ],
    ));
  }
}
