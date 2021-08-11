import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';
import 'package:weather_location_search/view/home/widgets/body_data.dart';
import 'package:weather_location_search/view/home/widgets/search_bar.dart';

import 'widgets/backimg.dart';
import 'widgets/location_deny_request_again.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    var appBar = AppBar(
      title: Text('weather'),
      backgroundColor: Colors.transparent,
      leading: Icon(
        Icons.dark_mode,
        color: Colors.black,
      ),
      actions: [
        Icon(
          Icons.light_mode,
          color: Colors.black,
        ),
        SizedBox(width: 15),
      ],
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: Text('weather'),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          BackImg(),
          Container(
            width: w,
            height: h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar,
                SearchBar(),
                Expanded(child: homeChild(context)),
              ],
            ),
          ),
        ],
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
      return BodyData(cubit.locationWeatherModel!);
    } else {
      return Text('open setting and give app location permission ..');
    }
  }
}


