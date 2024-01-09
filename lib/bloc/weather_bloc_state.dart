import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_bloc/models/weather_model.dart';

@immutable
abstract class WeatherBlocState extends Equatable {}

class WeatherBlocInitial extends WeatherBlocState{
  @override
  List<Object?> get props => [];

}

class WeatherLoading extends WeatherBlocState {
  @override
  List<Object?> get props => [];
}

class WeatherSuccess extends WeatherBlocState {
  final WeatherModel weather;
  WeatherSuccess(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherBlocState {
  final String error;
  WeatherError(this.error);
  @override
  List<Object?> get props => [error];
}