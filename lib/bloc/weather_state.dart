
import 'package:equatable/equatable.dart';
import 'package:weather_app_bloc/models/weather_model.dart';

abstract class WeatherState extends Equatable {}

class InitialState extends WeatherState {
  @override
  List<Object> get props => [];
}
class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}
class WeatherSuccess extends WeatherState {
  WeatherSuccess(this.weather);
  
  final WeatherModel weather;
  
  @override
  List<Object> get props => [weather];
}
class ErrorState extends WeatherState {
  @override
  List<Object> get props => [];
}