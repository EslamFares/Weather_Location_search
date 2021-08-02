import 'package:flutter/material.dart';
import 'package:weather_location_search/cubit/home/home_cubit.dart';
import 'package:weather_location_search/view/seach_result/seach_result.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    return Form(
      key: cubit.formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 80,
              width: w * .75,
              child: TextFormField(
                autofocus: false,
                controller: cubit.searchController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'enter city please,';
                  }
                  else if (value.toString().length == 2) {
                    return 'Minumam letters 3';
                  }
                },
                onFieldSubmitted: (value) {
                  print('valueee ====> $value');
                  print('conrtller ====> ${cubit.searchController.text}');
                },
                decoration: InputDecoration(
                  hintText: 'enter city name .. ',
                  labelText: 'city',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.red, width: 2)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2)),
                ),
              )),
          Spacer(),
          InkWell(
            onTap: () {
              if (cubit.formKey.currentState!.validate()) {
                print('go');
                cubit.getWeather();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchReasult()));
                cubit.searchController.clear();
              } else
                print('no validate...');
            },
            child: Container(
                width: w * .15,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(Icons.search)),
          )
        ],
      ),
    );
  }
}
