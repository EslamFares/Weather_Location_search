import 'package:flutter/material.dart';
import 'package:weather_location_search/model/weather_model.dart';
import 'data_item.dart';
import 'text_container_color.dart';

class BodyData extends StatelessWidget {
  final WeatherModel weatherModel;
  const BodyData(this.weatherModel);
  @override
  Widget build(BuildContext context) {
    int temp =
        ((double.parse(weatherModel.main!.temp.toString()) - 32) * (5 / 9))
            .round();
    String img = temp > 20 ? 'assets/img/cloud.jpeg' : 'assets/img/rain.jpg';
    double w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image:
                  DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
        ),
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextContainerColor('City'),
                TextContainerColor(
                  weatherModel.name.toString(),
                  width: w * .5,
                ),
              ],
            ),
            Column(
              children: [
                TextContainerColor(
                  'Main Info',
                  width: w * .5,
                ),
                DataItem(title: 'temp', data: temp.toString() + '°C'),
                DataItem(
                  title: 'pressure',
                  data: weatherModel.main!.pressure.toString(),
                ),
                DataItem(
                  title: 'humidity',
                  data: weatherModel.main!.humidity.toString(),
                ),
              ],
            ),
            Column(
              children: [
                TextContainerColor('wind'),
                DataItem(
                  title: 'speed',
                  data: weatherModel.wind!.speed.toString(),
                ),
                DataItem(
                  title: 'deg',
                  data: weatherModel.wind!.deg.toString(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextContainerColor('Country'),
                TextContainerColor(weatherModel.sys!.country.toString()),
              ],
            ),
            Column(
              children: [
                TextContainerColor('weather'),
                DataItem(
                  title: 'main',
                  data: weatherModel.weather![0].main.toString(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
