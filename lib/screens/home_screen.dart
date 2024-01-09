import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_cubit.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().getLatestWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ));
          }
          if (state is WeatherSuccess) {
            return Padding(
              padding:
                  const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.2),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(color: Colors.orange),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${state.weather.name} ,",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                state.weather.sys.country,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                           Text(
                            state.weather.weather[0].description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Image.asset('assets/images/${_getIconAccordingToCode(state.weather.weather[0].icon)}.png'),
                           Center(
                            child: Text(
                             "${ _convertToCelcius(state.weather.main.temp).toString()}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                           Center(
                            child: Text(
                                 state.weather.weather[0].main,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Center(
                            child: Text(
                             "Last Updated: ${_getClockInUtcPlus3Hours(state.weather.dt)}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageWithDescription(
                                imageName: '11',
                                name: 'Sunrise',
                                subTitle: _getClockInUtcPlus3Hours(state.weather.sys.sunrise).toString(),
                              ),
                              ImageWithDescription(
                                imageName: '12',
                                name: 'Sunset',
                              subTitle: _getClockInUtcPlus3Hours(state.weather.sys.sunset).toString(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageWithDescription(
                                imageName: '13',
                                name: 'Temp Max',
                                subTitle: "${_convertToCelcius(state.weather.main.tempMax).toString()}°C"
                              ),
                              ImageWithDescription(
                                imageName: '14',
                                name: 'Temp Min',
                                subTitle: "${_convertToCelcius(state.weather.main.tempMin).toString()}°C"
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ImageWithDescription extends StatelessWidget {
  const ImageWithDescription({
    super.key,
    required this.imageName,
    required this.name,
    required this.subTitle,
  });
  final String imageName;
  final String name;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/$imageName.png',
              scale: 8,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}


int _convertToCelcius(double temp){
  return (temp - 273.15).round();
}
String _getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
  final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000);
  return '${time.hour}:${time.second}';
}

String _getIconAccordingToCode(String code){
  switch(code){
    case '01d' || '01n':
      return '6';
    case '02d' || '02n':
      return '7';
    case '03d' || '03n':
      return '8';
    case '04d' || '04n':
      return '9';
    case '10d' || '10n':
      return '2';
    case '11d' || '11n':
      return '1';
    case '13d' || '13n':
      return '4';
    case '50d' || '50n':
      return '5';
    default:
      return '6';
  }
}