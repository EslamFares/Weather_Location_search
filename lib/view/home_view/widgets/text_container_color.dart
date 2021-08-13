import 'package:flutter/material.dart';
import 'package:weather_location_search/shared/themes/dark_theme.dart';

class TextContainerColor extends StatelessWidget {
  final String text;
  final double width;
  const TextContainerColor(this.text, {this.width = 150});
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width == 150 ? w * .3 : width,
            height: 50,
            decoration: BoxDecoration(
                color: dSecColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
