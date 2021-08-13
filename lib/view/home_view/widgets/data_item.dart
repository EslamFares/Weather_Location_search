import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  const DataItem({
    required this.title,
    required this.data,
  });

  final String title, data;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
          SizedBox(width: 10),
          Container(width: w * .2, child: Text(title)),
          SizedBox(width: 20),
          Container(width: w * .35, child: Text('-' * 30)),
          SizedBox(width: 20),
          Container(width: w * .2, child: Text(data)),
        ],
      ),
    );
  }
}
