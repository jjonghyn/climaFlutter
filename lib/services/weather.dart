import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

//발급받은 나의 api
const apiKey = '72ca2487d6bb7bee4863683ce17918c7';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  //지역 날씨 구하기
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //위도 경도를 가져와 API를 통해 날씨 정보 가져오기
  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    //위경도 가져오기
    await location.getCurrentLocation();

    //현재나의 위경도를 기준으로 날씨 구하기
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //api condition값에 따라 아이콘 바꾸기
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  //api로 받은 온도에 따라 날씨코멘트 return
  String getMessage(int temp) {
    if (temp > 25) {
      return '더워요';
    } else if (temp > 20) {
      return '적당해요';
    } else if (temp > 10) {
      return '쌀쌀해요';
    } else {
      return '춥습니다';
    }
  }
}