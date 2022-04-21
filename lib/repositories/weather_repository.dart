import '../exceptions/weather_exception.dart';
import '../models/user_custom_error.dart';
import '../models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);
      //print('woeid: $woeid');

      final Weather weather = await weatherApiServices.getWeather(woeid);
      //print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
