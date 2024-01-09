import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc_state.dart';
import 'package:weather_app_bloc/models/weather_model.dart';
import 'package:weather_app_bloc/repository/weather_repository.dart';
part 'weather_bloc_event.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final WeatherRepository weatherRepository;
  WeatherBlocBloc(this.weatherRepository) : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherModel weather = await weatherRepository.getWeather();
        emit(WeatherSuccess(weather));
      } catch (e) {
       emit(WeatherError(e.toString()));
      }
    });
  }
}
