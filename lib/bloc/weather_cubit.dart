

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';
import 'package:weather_app_bloc/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository}) : super(InitialState());


void getLatestWeather() async {
  try {
    emit(WeatherLoading());
    final weather = await weatherRepository.getWeather();
    emit(WeatherSuccess(weather));
  } catch (e) {
    emit(ErrorState());
  }
}

}
