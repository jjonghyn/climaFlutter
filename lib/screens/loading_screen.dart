import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  //날씨데이터 가져오기
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    //날씨데이터를 가지고 LocationScreen으로
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  //spinKit라이브러리로 로딩구현
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}